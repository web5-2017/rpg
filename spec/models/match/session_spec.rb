require 'rails_helper'

RSpec.describe Match::Session, type: :model do
  let!(:user) { create(:user_actived)}
  let!(:history) { create(:history, user: user) }
  let!(:history2) { create(:history, user: user) }
  let!(:map) { create(:map, history: history) }
  let!(:map2) { create(:map, history: history2) }
  let!(:game) { create(:game, user: user, histories: [history]) }
  let!(:base_log) { "Partida criada\nEsperando jogadores..." }

  describe 'Comandos do mestre' do
    it 'Deve criar um log depois de iniciar a sessão' do
      session = Match::Session.new game_id: game.id

      expect(session.log).to eq base_log
    end

    it 'Deve mudar o status para aberto e mudar o log' do
      session = Match::Session.new game_id: game.id
      session.save

      session.master_exec('\start', 'Mestre')
      expect(session.opened).to eq true
      expect(session.log).to eq base_log + "\nMestre# - \\start\nPartida iniciada"
    end

    it 'Deve gerar um help no log' do
      session = Match::Session.new game_id: game.id
      session.save

      help_text = "\n-------------- help\n\\start - para iniciar a partida\n\\set_map [id do mapa] - exemplo: \\set_map 2"

      session.master_exec('\help', 'Mestre')
      expect(session.log).to eq base_log + "\nMestre# - \\help" + help_text
    end

    it 'Deve mostrar que o mando não existe' do
      session = Match::Session.new game_id: game.id
      session.save

      session.master_exec('teste', 'Mestre')
      expect(session.log).to eq base_log + "\nMestre# - teste\nComando desconhecido"
    end

    it 'Deve mudar o mapa atual da sessão' do
      session = Match::Session.new game_id: game.id
      session.save

      session.master_exec("\\set_map #{map.id}", 'Mestre')
      expect(session.log).to eq base_log + "\nMestre# - \\set_map #{map.id}\nMapa atual alterado"
      expect(session.map_id).to eq map.id
    end

    it 'Deve informar no log que o mapa não existe' do
      session = Match::Session.new game_id: game.id
      session.save

      session.master_exec("\\set_map #{map2.id}", 'Mestre')
      expect(session.log).to eq base_log + "\nMestre# - \\set_map #{map2.id}\nEsse mapa não existe"
      expect(session.map_id).to eq nil
    end
  end

  describe "Comandos do Player" do
    it 'Deve gerar um help no log' do
      session = Match::Session.new game_id: game.id
      session.save

      help_text = "\n-------------- help"

      session.player_exec('\help', 'User')
      expect(session.log).to eq base_log + "\nUser# - \\help" + help_text
    end

    it 'Deve mostrar que o mando não existe' do
      session = Match::Session.new game_id: game.id
      session.save

      session.player_exec('teste', 'User')
      expect(session.log).to eq base_log + "\nUser# - teste\nComando desconhecido"
    end
  end

end
