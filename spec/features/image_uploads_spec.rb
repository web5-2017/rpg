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
      page.attach_file('file_upload', Rails.root + 'spec/images/perfil.jpg')
      find("a[href='#{picture_path}']").click

      lis = page.all('ul#pictures li').map(&:text)
      lis.should include(1)
    end
  end
end
