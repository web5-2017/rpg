require 'rails_helper'

RSpec.feature "SearchUsers", type: :feature do
  let!(:users) { create_list(:user_actived, 100) }
  let!(:user) { create(:user_actived) }
  before { sign_in user.email, user.password }

  before do
    visit '/profile/search_users'
  end

  def search(user)
    within(".form-inline") do
      fill_in 'search[query]', with: user.name
    end

    find('input[name="commit"]').click
  end

  it 'Deve conter um input de busca' do
    expect(page).to have_css "input[name='search[query]']"
  end

  describe 'Buscando usuários' do

    context 'Não deve retornar' do
      it 'o usuário da sessão' do
        search user
        expect(page).to_not have_css("table", text: user.name)
      end

      it 'um usuário sem relação  a busca' do
        search users.first
        expect(page).to_not have_css("table", text: users.last.name)
      end
    end

    context 'Deve retornar' do
      it 'um usuário' do
        search users.first
        expect(page).to have_css("table", text: users.first.name)
      end
    end
  end

  describe 'Adicionando um usuário' do

    it 'Deve adicionar um usuário' do
      search users.first
      find("#user_#{users.first.id}").click

      expect(user.friend_list).to include users.first
    end

    it 'não deve adicionar um usuário que ja é amigo' do
      search users.first
      find("#user_#{users.first.id}").click


      expect(page).to_not have_css("#user_#{users.first.id}")
    end

  end
end
