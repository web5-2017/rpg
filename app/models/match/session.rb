class Match::Session < ApplicationRecord
  belongs_to :game

  after_initialize :initial_log

  HELP = "-------------- help\n\\start - para iniciar a partida"

  def run(code, user)
    inserting_in_the_log "#{user.name}# - #{code}"

    case code
    when '\start'
      inserting_in_the_log "Partida iniciada"
      self.opened = true
    when '\help'
      inserting_in_the_log HELP
    end

    self.save
  end

  def inserting_in_the_log(text)
    self.log += "\n" + text
  end

  private

  def initial_log
    if self.id.nil?
      self.log = "Partida criada\nEsperando jogadores..."
    end
  end
end
