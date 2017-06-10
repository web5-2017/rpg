class GmMatch::SessionsController < GmMatch::AppGmMatchControllerController

  def create
    match_session = @game.sessions.new
    match_session.save

    redirect_to gm_match_root_path(@game)
  end

  def run_code
    code = params[:code]

    match_session = @game.sessions.find params[:id]
    match_session.master_exec code, 'Mestre'

    redirect_to gm_match_root_path(@game)
  end
end
