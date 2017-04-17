require 'rails_helper'

RSpec.feature "Maps", type: :feature do
  let!(:user) { create(:user_actived) }
  let!(:history) { create(:history) }

  before { sign_in user.email user.password }

  describe 'Criando um mapa' do
    before { visit "/match/histories/#{history.id}/maps/new" }

    context 'casos de sucessos' do

      it 'deve criar um novo mapa'

      it 'caso existir deve deve editar o mesmo'

      it 'o json_map deve ser criado corretamente'

    end

    context 'casos de erros' do

      it 'o mapa não pode passar dos limites de tamanho'

      it 'o json_map não pode ser criado de maneira incorreta'

    end

  end

end
