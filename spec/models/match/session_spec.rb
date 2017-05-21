require 'rails_helper'

RSpec.describe Match::Session, type: :model do
  let!(:user) { create(:user_actived)}
  let!(:game) { create(:game, user: user) }
  let!(:base_log) { "Partida criada\nEsperando jogadores..." }

  it 'Deve criar um log depois de iniciar a sessão' do
    session = Match::Session.new game_id: game.id

    expect(session.log).to eq base_log
  end

  it 'Deve mudar o status para aberto e mudar o log' do
    session = Match::Session.new game_id: game.id
    session.save

    session.run('\start', user)
    session.reload

    expect(session.opened).to eq true
    expect(session.log).to eq base_log + "\n#{user.name}# - \\start\nPartida iniciada"
  end

  it 'Deve gerar um help no log' do
    session = Match::Session.new game_id: game.id
    session.save

    help_text = "\n-------------- help\n\\start - para iniciar a partida"

    session.run('\help', user)
    expect(session.log).to eq base_log + "\n#{user.name}# - \\help" + help_text
  end

end
