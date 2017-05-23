module GmMatch::DashboardHelper

  def match_status(match)
    match.opened ? "Partida em andamento" : "Partida em espera"
  end

end
