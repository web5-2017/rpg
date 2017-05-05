require 'rails_helper'

RSpec.feature "Characters", type: :feature do
  let!(:user) { create(:user_actived) }
  let!(:game) { create(:game, user: user) }
  before { sign_in user.email, user.password }

  describe 'Mostrando o Personagem' do
    let!(:character) { create(:character, game: game) }
    before { visit "/profile/games/#{game.id}/characters/#{character.id}" }

    it "deve conter o titulo com o nome" do
      expect(page).to have_css("h1", text: character.name)
    end
  end

  describe 'Criando personagem' do
    before { visit "/profile/games/#{game.id}/characters/new" }

    context 'sucesso' do
      before do
        within("#new_character") do
          fill_in 'character[name]', with: 'Teste'
          fill_in 'character[description]', with: "teste"
        end

        find('input[name="commit"]').click
      end

      it "deve conter o titulo com o nome" do
        expect(page).to have_css("h1", text: Character.last.name)
      end

      it 'deve ter criado o personagem' do
        expect(Character.count).to eq 1
      end
    end

    context 'erro' do
      before do
        within("#new_character") do
          fill_in 'character[name]', with: nil
        end

        find('input[name="commit"]').click
      end

      it "deve conter a mensagem de erro" do
        expect(page).to have_content "erro ao criar o personagem"
      end

      it 'não deve criar o personagem' do
        expect(Character.count).to eq 0
      end
    end
  end

  describe 'Editando personagem' do
    let!(:character) { create(:character, game: game) }
    before { visit "/profile/games/#{game.id}/characters/#{character.id}/edit" }

    before do
      within("#edit_character_#{character.id}") do
        fill_in 'character[name]', with: 'Teste'
      end

      find('input[name="commit"]').click
    end

    it "deve conter o titulo com o novo nome" do
      expect(page).to have_css("h1", text: character.reload.name)
    end
  end
end
