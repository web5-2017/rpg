require 'rails_helper'

RSpec.feature "ImageUploads", type: :feature do
  let!(:user) {create(:user_actived)}

  before do
    sign_in user.email, user.password
  end

  describe 'Nova Partida' do
    before do
      visit '/match/games/new'
    end

    context 'Estilos da pagina' do
      it "Deve carregar a pagina de nova partida" do
        expect(page).to have_css("h1", text: "Nova Partida")
      end
    end

    context 'Interação' do
      context 'parâmetros corretos' do
        before do
          within("#new_game") do
            fill_in 'game[name]', with: 'Game Teste'
          end
          find('input[name="commit"]').click
        end

        it "Deve criar uma partida" do
          expect(Game.count).to eq 1
        end

        it "Deve redirecionar para o show da partida depois que criala" do
          expect(page).to have_current_path(match_game_path(Game.last))
          expect(page).to have_content 'partida criada'
        end
      end

      context 'parâmetros incorretos' do
        before do
          within("#new_game") do
            fill_in 'game[name]', with: ''
          end
          find('input[name="commit"]').click
        end

        it "Deve criar uma partida" do
          expect(Game.count).to eq 0
        end

        it "Deve redirecionar para o show da partida depois que criala" do
          expect(page).to have_content 'erro ao criar a partida'
        end
      end
    end
  end
end
