class Match::Session < ApplicationRecord
  belongs_to :game

  after_initialize :initial_log, :initialize_battle

  attr_accessor :battle, :current_char

  def player_exec(code, name, char)
    @current_char = char
    return false if @current_char.hp <= 0

    compiler = Match::Compiler.new(self, code, name, false)
    compiler.run

    self.save
  end

  def master_exec(code, name)
    compiler = Match::Compiler.new(self, code, name, true)
    compiler.run

    self.save
  end

  def inserting_in_the_log(text)
    self.log += "\n" + text
  end

  def have_permission_in_map?(id)
    game.histories.each do |h|
      return true if h.maps.exists?(id)
    end

    false
  end

  def create_battle(mobs_ids)
    chars = generate_chars
    mobs_ids.each { |id| chars << game.chars.find(id) }

    @battle = Match::Battle.new characters: chars, total: chars.size, turn: 0
    @battle.next
    self.battle_string= @battle.to_s

    save
  end

  def load_battle
    @battle = Match::Battle.parse battle_string
  end

  def set_skill(id)
    @current_char.set_skill id
  end

  def atk(target, magic, current_char = nil)
    @current_char = current_char if current_char

    if @battle.nil?
      inserting_in_the_log "Você não está em uma batalha"
      return false
    elsif !@battle.characters_ids.include? @current_char.id
      inserting_in_the_log "Esse personagem não está na batalha"
      return false
    elsif !@battle.characters_ids.include? target.id
      inserting_in_the_log "Esse alvo não está na batalha"
      return false
    elsif @battle.character_turn_id != @current_char.id
      inserting_in_the_log "Espere sua vez para atacar"
      return false
    elsif(@current_char.hp <= 0)
      inserting_in_the_log "O #{target.name} está morto!!"
      return false
    else
      @current_char.attack target: target, dice: self.current_dice, magic_atk: magic
      @battle.next
      self.battle_string = @battle.to_s
      return true
    end
  end

  def send_exp(exp, char)
    char.add_exp(exp)
  end

  private

  def generate_chars
    chars = []
    game.players.each do |player|
      chars << player.characters.find_by(game_id: game.id)
    end

    return chars
  end

  def initial_log
    if self.id.nil?
      self.log = "Partida criada\nEsperando jogadores..."
    end
  end

  def initialize_battle
    load_battle unless self.battle_string.nil?
  end
end
