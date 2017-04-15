require 'rails_helper'

RSpec.feature "Profiles", type: :feature do
  let!(:user) {create(:user_actived)}

  context 'layout' do
    before do
      sign_in user.email, user.password
      visit '/profile'
    end

    it 'Deve ativar a link do sidebar' do
      expect(page).to have_css "#sidebar li[class*='active'] a[href*='/profile']"
    end
  end

  context "perfil do usuário (visualização)" do
    before do
      sign_in user.email, user.password
      visit '/profile/edit'
    end

    it 'Deve conter a imagem default para o usuário' do
      expect(page).to have_css "img[src*='/fallback/user/default-avatar.jpg']"
    end

    it 'Deve conter a foto do usuário' do
      expect(page).to have_css "img[src*='#{user.avatar}']"
    end

    it 'Deve conter informções do usuário' do
      expect(page).to have_css("h3", text: "Perfil de #{user.name}")
    end

  end
end
