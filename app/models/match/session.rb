class Match::Session < ApplicationRecord
  belongs_to :game

  after_initialize :initial_log

  attr_accessor :battle

  def player_exec(code, name)
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
    battle_string= @battle.to_s

    save
  end

  def load_battle
    @battle = Match::Battle.parse battle_string
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
end
