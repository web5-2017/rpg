require 'rails_helper'

RSpec.feature "Challenges", type: :feature do
  let!(:user) { create(:user_actived) }
  let!(:game) { create(:game, user: user) }
  let!(:history) { create(:history, user: user, games: [game]) }
  before { sign_in user.email, user.password }

  describe 'Novo' do
    before { visit new_profile_game_history_challenge_path(game, history) }

    context 'com sucesso' do
      before do
        within("#new_challenge") do
          fill_in 'challenge[name]', with: "test"
          fill_in 'challenge[description]', with: 'test'
          fill_in 'challenge[alternatives_attributes][0][content]', with: 'test'
          fill_in 'challenge[alternatives_attributes][1][content]', with: 'test'
        end

        find('input[name="commit"]').click
      end

      it 'deve retornar uma mensagem de sucesso' do
        expect(page).to have_content 'Desafio criado com sucesso'
      end

      it 'deve redirecionar para o show' do
        expect(page).to have_current_path(profile_game_history_challenge_path(
                    game.id, history.id, Challenge.last.id))
      end

      it 'deve criar um novo challenge' do
        expect(Challenge.count).to eq 1
      end
    end

    context 'com falha' do
      before do
        within("#new_challenge") do
          fill_in 'challenge[name]', with: nil
          fill_in 'challenge[description]', with: 'test'
          fill_in 'challenge[alternatives_attributes][0][content]', with: 'test'
          fill_in 'challenge[alternatives_attributes][1][content]', with: nil
        end

        find('input[name="commit"]').click
      end

      it 'deve retornar uma mensagem de sucesso' do
        expect(page).to have_content 'Erro ao criar o desavio'
        expect(page).to have_content 'não pode ficar em branco'
      end

      it 'deve criar um novo challenge' do
        expect(Challenge.count).to eq 0
      end
    end
  end

  describe 'Atualizar' do
    let!(:challenge) { create(:challenge, game: game, history: history) }
    let!(:alternatives) { create_list(:alternative, 5, challenge: challenge) }

    before do
      visit edit_profile_game_history_challenge_path(game, history, challenge)

      within("#edit_challenge_#{challenge.id}") do
        fill_in 'challenge[name]', with: "test"
        fill_in 'challenge[description]', with: 'test'
        fill_in 'challenge[alternatives_attributes][0][content]', with: 'test'
        fill_in 'challenge[alternatives_attributes][1][content]', with: 'test'
      end

      find('input[name="commit"]').click
    end

    it 'deve retornar uma mensagem de sucesso' do
      expect(page).to have_content "Desafio test atualizado"
    end

    it 'deve redirecionar para o show' do
      expect(page).to have_current_path(profile_game_history_challenge_path(
                  game.id, history.id, Challenge.last.id))
    end

    it 'deve criar um novo challenge' do
      expect(challenge.reload.name).to eq 'test'
    end
  end

  describe 'excluindo' do
    let!(:challenge) { create(:challenge, game: game, history: history) }
    let!(:alternative) { create(:alternative, challenge: challenge) }

    before do
      visit profile_game_history_challenges_path(game, history)
      find('#table-challenges a[data-method="delete"]').click
    end

    it 'deve excluir o desafio' do
      expect(Challenge.count).to eq 0
    end

    it 'deve redirencionar para o index' do
      expect(page).to have_current_path(profile_game_history_challenges_path(game, history))
    end
  end
end
