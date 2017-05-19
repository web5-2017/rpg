require 'rails_helper'

RSpec.feature "GmArea", type: :feature do
  let!(:user) { create(:user_actived) }
  let!(:user2) { create(:user_actived) }
  let!(:game) { create(:game, user: user) }
  let!(:game2) { create(:game, user: user2) }
  before { sign_in user.email, user.password }

  describe "Permissões de acesso" do

    it "Acessar a página do game criado" do
      visit "/gm_match/game/#{game.id}/"

      expect(page).to have_content game.name
    end

    it "Não deve acessar a página caso não exista o game ou não seja o dono do game" do
      visit "/gm_match/game/#{game2.id}/"

      expect(page).to have_content "Partida não encontrada, tem certeza que você criou ela?"
    end
  end

end
