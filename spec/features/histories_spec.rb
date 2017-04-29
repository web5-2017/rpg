require 'rails_helper'

RSpec.feature "Histories", type: :feature do
  let!(:user) { create(:user_actived) }
  let!(:game) { create(:game, user: user) }
  before { sign_in user.email, user.password }

  describe 'layout' do
    let!(:history) { create(:history, user: user) }

    before { visit "/profile/my-histories" }

    it 'deve conter os links para excluir' do
      expect(page).to have_css "a[data-method='delete']"
    end

    it 'deve conter os links para editar' do
      expect(page).to have_css "a[href='#{edit_profile_history_path(history)}']"
    end
  end

  describe 'Mostrando as historias' do
    let!(:histories) do
      create_list(:history, 5, games: [game], user: user)
      game.histories.order :title
    end

    before { visit "/profile/games/#{game.id}" }

    context 'listagem de historias' do
      it 'Deve conter a tabela #table-histories' do
        expect(page).to have_css "#table-histories"
      end

      it 'Deve conter as historias na tabela #table-histories' do
        index = 0
        page.all('#table-histories tbody tr').each do |tr|
          expect(tr).to have_content "#{histories[index].title}"
          index += 1
        end
      end
    end
  end

  describe 'Partidas' do
    let!(:history) { create(:history, user: user) }

    context 'Adicionando uma História' do
      before do
        visit "/profile/games/#{game.id}/histories"
        find("a[href=\"/profile/games/#{game.id}/histories/#{history.id}/add_history\"]").click
      end

      it 'Deve conter uma' do
        expect(game.reload.histories.count).to eq 1
      end
    end

    context 'Removendo uma História' do
      before do
        visit "/profile/games/#{game.id}"
        find('a[data-method="delete"]').click
      end

      it 'Deve conter nenhuma' do
        expect(game.reload.histories.count).to eq 0
      end
    end

  end
end
