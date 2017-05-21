class GmMatch::DashboardController < GmMatch::AppGmMatchControllerController

  def index
    @match_session = @game.session.find_by closed: false
  end

end
