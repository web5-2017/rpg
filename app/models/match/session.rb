class Match::Session < ApplicationRecord
  belongs_to :game
  belongs_to :map

  after_initialize :initial_log

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
  private

  def initial_log
    if self.id.nil?
      self.log = "Partida criada\nEsperando jogadores..."
    end
  end
end
