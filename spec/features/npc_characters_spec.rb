require 'rails_helper'

RSpec.feature "NpcCharacters", type: :feature do
  let!(:user) { create(:user_actived) }
  let!(:game) { create(:game, user: user) }
  let!(:breed) { create(:breed, game: game) }
  let!(:character) { create(:character, game: game, breeds: [breed]) }

  before { sign_in user.email, user.password }

  describe "Listando os npcs" do
    let!(:npcs) { create_list(:user_character, 10, user: user,
                                                   game: game,
                                                   character_type: 'npc',
                                                   breed: breed,
                                                   character: character) }

    before { visit "/gm_match/game/#{game.id}/characters/npc" }

    it 'Deve retornar todos os npcs' do
      index = 0
      page.all('table tbody tr').each do |tr|
        expect(tr).to have_content "#{npcs[index].name}"
        index += 1
      end
    end
  end
end
