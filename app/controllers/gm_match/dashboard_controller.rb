class GmMatch::DashboardController < GmMatch::AppGmMatchControllerController

  def index
    @match_session = @game.sessions.last
  end

end
