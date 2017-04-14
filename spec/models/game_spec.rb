require 'rails_helper'

RSpec.describe Game, type: :model do
  let!(:gm) { create(:user_actived) }
  let!(:players) { create_list(:user_actived, 5) }
  let!(:game) { create(:game, user: gm, players: players) }

  describe 'Definir Players e GM' do
      it 'Deve retornar os players' do
        expect(game.players).to eq players
      end

      it 'Deve reportar o gm' do
        expect(game.user).to eq gm
      end

      it 'Não deve adicionar o mesmo player duas vezes' do
        expect { game.players << players }.to raise_error(ActiveRecord::RecordNotUnique)
      end
  end
end
