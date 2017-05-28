class GmMatch::DashboardController < GmMatch::AppGmMatchControllerController

  def index
    @match_session = @game.sessions.find_by closed: false
  end

end
