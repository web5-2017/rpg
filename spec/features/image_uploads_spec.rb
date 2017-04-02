require 'rails_helper'

RSpec.feature "ImageUploads", type: :feature do
  let!(:user) {create(:user_actived)}

  before do
    sign_in user.email, user.password
    visit '/pictures'
  end

  context 'Area para visualisar todas as imagens' do

    it 'deve contar o title da pagina' do
      expect(page).to have_css("h1", text: "Imagens do Servidor")
    end

    it 'deve adicionar uma picture' do
      page.attach_file('picture[image]', Rails.root + 'spec/images/perfil.jpg')
      find("#commit-picture").click

      lis = page.all('ul#gallery li').map(&:text)
      expect(lis.length).to eq 2
    end
  end
end
