require 'rails_helper'

RSpec.feature "Maps", type: :feature do
  let!(:user) { create(:user_actived) }
  let!(:history) { create(:history, user: user) }

  before { sign_in user.email, user.password }

  describe 'Criando' do
    context 'Com sucesso' do
      before do
        visit "/match/histories/#{history.id}/maps/new"

        within("#new_map") do
          fill_in 'map[name]', with: 'test'
          fill_in 'component_name', with: 'Component Test'
          fill_in 'component_color', with: '#784747'
        end

        find('button[name="add_component"]').click
        find('input[name="commit"]').click
      end

      it 'Deve criar um novo mapa' do
        expect(Map.count).to eq 1
      end

      it 'Deve criar um novo mapa com nome test' do
        expect(Map.last.name).to eq 'test'
      end

      it 'Deve redirecionar para o show do map' do
        expect(page).to have_content "test"
      end
    end
  end

end
