require 'rails_helper'

RSpec.describe Match::Session, type: :model do
  let!(:gm) { create(:user_actived)}
  let!(:player) { create(:user_actived)}
  let!(:game) { create(:game, user: gm, players: [player]) }
  let!(:skill) { create(:skill) }
  let!(:breed) { create(:breed, game: game) }
  let!(:character) { create(:character, breeds: [breed], skills: [skill], game: game) }
  let!(:char) { create(:user_character, user: player, dex: 3, character: character, breed: breed, game: game) }
  let!(:mob_1) { create(:user_character, user: gm, dex: 30, character: character, breed: breed, game: game) }
  let!(:mob_2) { create(:user_character, user: gm, dex: 20, character: character, breed: breed, game: game) }
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

      help_text = "\n-------------- help\n\\start - para iniciar a partida\n\\battle_start [ids dos inimigos da batalha] exemplo: \\battle_start 1 4 5 20 - Para dar inicio a uma batalha\n\\atk [id do alvo] [id do personagem] exemplo: atk 3 2 - Para atacar um personagem\n\\current_dice [tipo do dado] exemplo: \\current_dice 6 - Muda o dado a ser usado nos ataques\n\\send_exp [quantidade de exp] [id(s) dos(s) personagem(s)] exemplo: \\send_exp 8 4 \\send_exp 8 4 3 - Para dar exp para um ou mais personagens\n\\cast_dice [tipo do dado] exemplo: \\cast_dice 6 - Joga um dado (Apenas joga e mostra o valor)\n\\set_skill [id do personagem] [id da habilidade] exemplo: \\set_skill 2 3 - Prepara a habilidade para o ataque"

      session.master_exec('\help', 'Mestre')
      expect(session.log).to eq base_log + "\nMestre# - \\help" + help_text
    end

    it 'Deve mostrar que o mando não existe' do
      session = Match::Session.new game_id: game.id
      session.save

      session.master_exec('teste', 'Mestre')
      expect(session.log).to eq base_log + "\nMestre# - teste\nComando desconhecido"
    end

    it 'Não Deve criar uma batalha se a partida não iniciou' do
      session = Match::Session.new game_id: game.id
      session.save

      log_text = "\nPara iniciar uma batalha, deve primeiro dar inicio na partida com '\\start'"

      session.master_exec("\\battle_start #{mob_1.id} #{mob_2.id}", 'Mestre')
      expect(session.log).to eq base_log + "\nMestre# - \\battle_start #{mob_1.id} #{mob_2.id}" + log_text
    end

    it 'Deve criar uma batalha' do
      session = Match::Session.new game_id: game.id
      session.save
      session.master_exec('\start', 'Mestre')

      log_text = session.log + "\nMestre# - \\battle_start #{mob_1.id} #{mob_2.id}\nBatalha iniciada\nÉ a vez de #{mob_1.name}"

      session.master_exec("\\battle_start #{mob_1.id} #{mob_2.id}", 'Mestre')
      expect(session.log).to eq log_text
      expect(session.battle.character_turn).to eq mob_1
      expect(session.battle.character_turn_id).to eq mob_1.id
    end

    it 'Deve atacar um personagem' do
      session = Match::Session.new game_id: game.id
      session.save
      session.master_exec('\start', 'Mestre')
      session.master_exec("\\battle_start #{mob_1.id} #{mob_2.id}", 'Mestre')

      current_hp = char.hp

      log_text = session.log + "\nMestre# - \\atk #{char.id} #{mob_1.id}\nO #{mob_1.name} atacou o #{char.name}"

      session.master_exec("\\atk #{char.id} #{mob_1.id}", 'Mestre')
      log_text += "\nÉ a vez de #{session.battle.character_turn.name}"
      char.reload
      session.reload
      expect(session.log).to eq log_text
      expect(current_hp > char.hp).to eq true
      expect(session.battle.character_turn_id).to eq mob_2.id
    end

    it 'Deve eliminar o inimigo' do
      session = Match::Session.new game_id: game.id
      session.save
      session.master_exec('\start', 'Mestre')
      session.master_exec("\\battle_start #{mob_1.id} #{mob_2.id}", 'Mestre')

      char.hp = 1
      char.save

      log_text = session.log + "\nMestre# - \\atk #{char.id} #{mob_1.id}\nO #{mob_1.name} atacou o #{char.name}"

      session.master_exec("\\atk #{char.id} #{mob_1.id}", 'Mestre')

      log_text += "\nÉ a vez de #{session.battle.character_turn.name}\nO #{char.name} morreu"

      char.reload

      expect(session.log).to eq log_text
      expect(char.hp <= 0).to eq true
    end

    it 'Deve dar exp para um personagem' do
      session = Match::Session.new game_id: game.id
      session.save
      session.master_exec('\start', 'Mestre')
      exp = char.exp

      log_text = session.log + "\nMestre# - \\send_exp 5 #{char.id}\n#{char.name} recebeu 5 de exp"

      session.master_exec("\\send_exp 5 #{char.id}", 'Mestre')
      char.reload
      expect(session.log).to eq log_text
      expect(char.exp - 5).to eq exp
    end
  end

  describe "Comandos do Player" do
    it 'Deve gerar um help no log' do
      session = Match::Session.new game_id: game.id
      session.save

      help_text = "\n-------------- help\\atk [id do alvo] exemplo: atk 4 - Para atacar um personagem\n\\set_skill [id da skill] exemplo: \\set_skill 2 - Prepara a habilidade para o ataque\n\\cast_dice [tipo do dado] exmplo: \\cast_dice 6 - Joga um dado (Apenas joga e mostra o valor)"

      session.player_exec('\help', 'User', char)
      expect(session.log).to eq base_log + "\nUser# - \\help" + help_text
    end

    it 'Deve mostrar que o mando não existe' do
      session = Match::Session.new game_id: game.id
      session.save

      session.player_exec('teste', 'User', char)
      expect(session.log).to eq base_log + "\nUser# - teste\nComando desconhecido"
    end

    it 'Deve atacar um personagem' do
      session = Match::Session.new game_id: game.id
      session.save
      session.master_exec('\start', 'Mestre')
      session.master_exec("\\battle_start #{mob_1.id} #{mob_2.id}", 'Mestre')
      session.master_exec("\\atk #{char.id} #{mob_1.id}", 'Mestre')
      session.master_exec("\\atk #{char.id} #{mob_2.id}", 'Mestre')

      current_hp = mob_1.hp

      log_text = session.log + "\nUser# - \\atk #{mob_1.id}\nO User atacou o #{mob_1.name}"

      session.player_exec("\\atk #{mob_1.id}", 'User', char)

      mob_1.reload
      log_text += "\nÉ a vez de #{session.battle.character_turn.name}"

      expect(session.log).to eq log_text
      expect(current_hp > mob_1.hp).to eq true
      expect(session.battle.character_turn_id).to eq mob_1.id
    end

    it 'Não deve atacar um inimigo morto' do
      session = Match::Session.new game_id: game.id
      session.save
      session.master_exec('\start', 'Mestre')
      session.master_exec("\\battle_start #{mob_1.id} #{mob_2.id}", 'Mestre')
      session.battle.character_turn_id = char.id

      mob_1.hp = 0
      mob_1.save

      log_text = session.log + "\nUser# - \\atk #{mob_1.id}\nEsse personagem já morreu, por favor escolha outro para atacar"

      session.player_exec("\\atk #{mob_1.id}", 'User', char)

      expect(session.log).to eq log_text
    end

    it 'Não deve atacar um inimigo morto' do
      session = Match::Session.new game_id: game.id
      session.save
      session.master_exec('\start', 'Mestre')
      session.master_exec("\\battle_start #{mob_2.id}", 'Mestre')
      session.battle.character_turn_id = char.id


      log_text = session.log + "\nUser# - \\atk #{mob_1.id}\nEsse alvo não está na batalha"

      session.player_exec("\\atk #{mob_1.id}", 'User', char)
      expect(session.log).to eq log_text
    end

    it 'Deve selecionar uma skill para o ataque' do
      session = Match::Session.new game_id: game.id
      session.save
      session.master_exec('\start', 'Mestre')
      session.master_exec("\\battle_start #{mob_1.id} #{mob_2.id}", 'Mestre')
      session.battle.character_turn_id = char.id

      log_text = session.log + "\nUser# - \\set_skill #{skill.id}\nSkill selecionada"

      session.player_exec("\\set_skill #{skill.id}", 'User', char)
      expect(session.log).to eq log_text
      session.player_exec("\\atk #{mob_1.id}", 'User', char)
    end

    it 'Não deve selecionar a skill se não tiver mana' do
      session = Match::Session.new game_id: game.id
      session.save
      session.master_exec('\start', 'Mestre')
      session.master_exec("\\battle_start #{mob_1.id} #{mob_2.id}", 'Mestre')
      session.battle.character_turn_id = char.id
      char.mp = 0
      char.save

      log_text = session.log + "\nUser# - \\set_skill #{skill.id}\nVocê não tem essa skill ou não tem mana para executala"

      session.player_exec("\\set_skill #{skill.id}", 'User', char)
      expect(session.log).to eq log_text
      session.player_exec("\\atk #{mob_1.id}", 'User', char)
    end
  end

  describe 'Comandos compartilhados' do
    it 'Deve atacar um personagem' do
      session = Match::Session.new game_id: game.id
      session.save
      session.master_exec('\start', 'Mestre')
      session.master_exec("\\battle_start #{mob_2.id}", 'Mestre')

      log_text = session.log + "\nMestre# - \\atk #{char.id} #{mob_1.id}\nEsse personagem não está na batalha"

      session.master_exec("\\atk #{char.id} #{mob_1.id}", 'Mestre')

      expect(session.log).to eq log_text
    end

    it 'Deve lançar o dado' do
      session = Match::Session.new game_id: game.id
      session.save
      session.master_exec('\start', 'Mestre')

      pattern = /O Mestre jogou o dado e tirou [0-9]+$/

      session.master_exec('\cast_dice 6', 'Mestre')
      expect(pattern.match(session.log).nil?).to eq false
    end
  end

end
