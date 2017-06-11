class GmMatch::SessionsController < GmMatch::AppGmMatchControllerController

  def create
    match_session = @game.sessions.new
    match_session.save

    redirect_to gm_match_root_path(@game)
  end
end
