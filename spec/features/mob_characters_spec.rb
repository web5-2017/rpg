require 'rails_helper'

RSpec.feature "MobCharacters", type: :feature do
  let!(:user) { create(:user_actived) }
  let!(:game) { create(:game, user: user) }
  let!(:breed) { create(:breed, game: game) }
  let!(:character) { create(:character, game: game, breeds: [breed]) }
  let!(:mobs) { create_list(:user_character, 10, user: user,
                                                 game: game,
                                                 character_type: 'mob',
                                                 breed: breed,
                                                 character: character) }
  before { sign_in user.email, user.password }

  describe "Listando os npcs" do
    before { visit "/gm_match/game/#{game.id}/characters/mob" }

    it 'Deve retornar todos os npcs' do
      index = 0
      page.all('table tbody tr').each do |tr|
        expect(tr).to have_content "#{mobs[index].name}"
        index += 1
      end
    end
  end
end
