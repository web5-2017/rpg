require 'rails_helper'

RSpec.feature "SearchUsers", type: :feature do
  let!(:users) { create_list(:user_actived, 100) }
  let!(:user) { create(:user_actived) }
  before { sign_in user.email, user.password }

  before do
    visit '/profile/search_users'
  end

  it 'Deve conter um input de busca' do
    expect(page).to have_css "input[name='search[query]']"
  end

  it 'Não deve retornar o usuário da sessão' do
    within(".form-inline") do
      fill_in 'search[query]', with: user.name
    end

    find('input[name="commit"]').click

    expect(page).to_not have_css("table", text: user.name)
  end

  it 'Deve retornar um usuário' do
    within(".form-inline") do
      fill_in 'search[query]', with: users.first.name
    end

    find('input[name="commit"]').click

    expect(page).to have_css("table", text: users.first.name)
  end

  it 'Não deve retornar um usuário sem relação  a busca' do
    within(".form-inline") do
      fill_in 'search[query]', with: users.first.name
    end

    find('input[name="commit"]').click

    expect(page).to_not have_css("table", text: users.last.name)
  end
end
