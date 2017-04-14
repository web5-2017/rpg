require 'rails_helper'

RSpec.feature "Histories", type: :feature do
  let!(:user) { create(:user_actived) }
  let!(:game) { create(:game, user: user) }

  describe 'Mostrando as historias' do
    let!(:histories) do
      create_list(:history, 5, games: [game], user: user)
      game.histories.order :name
    end

    context 'listagem de historias' do
      before do
        sign_in user.email, user.password
        visit "/match/games/#{game.id}"
      end

      it 'Deve conter a tabela #table-histories' do
        expect(page).to have_css "#table-histories"
      end

      it 'Deve conter as historias na tabela #table-histories' do
        index = 0
        page.all('#table-histories tbody tr').each do |tr|
          expect(tr).to have_content "#{histories[index].name}"
          index += 1
        end
      end

    end

  end

end
