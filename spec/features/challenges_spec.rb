require 'rails_helper'

RSpec.feature "Challenges", type: :feature do
  let!(:user) { create(:user_actived)}
  let!(:game) { create(:game, user: user) }
  let!(:history) { create(:history, games: [game], user: user) }
  before { sign_in user.email, user.password }

  describe "Criando um novo desafio" do
    before { visit "/games/#{game.id}/history/#{history.id}/challenges/new" }

    context "Sucesso" do
      before do
        within("#new_challenge") do
          fill_in 'challenge[name]', with: "Name"
          fill_in 'challenge[description]', with: "Description"
          fill_in 'alternative[content]', with: "alternatives"
        end

        find('input[name="commit"]').click
      end

      it "Deve mostrar a mensagem de sucesso" do
        expect(page).to have_content "Desafio criado com sucesso"
      end

      it "Deve mostrar os detalhes do desafio" do
        expect(page).to have_css("h1", text: Challenge.last.name)
      end

      it "Deve criar um novo desafio" do
        expect(Challenge.count).to eq 1
      end

    end

    context "Fracasso" do

        it "Deve mostrar a mensagem de fracasso"

        it "Deve mostrar os erros no formulário"

        it "Deve criar mais de uma alternativa"

        it "Deve mostrar o erro \"Deve ser criado duas alternativa ou mais\""

        it "Não deve criar o desafio"

    end
  end

  describe "Mostrando" do

  end

  describe "Editando" do

  end

  describe "Deletando" do

  end

end
