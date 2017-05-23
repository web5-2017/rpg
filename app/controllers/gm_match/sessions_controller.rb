class GmMatch::SessionsController < GmMatch::AppGmMatchControllerController

  def create
    match_session = @game.session.new
    match_session.save

    redirect_to gm_match_root_path(@game)
  end

  def run_code
    code = params[:code]

    match_session = @game.session.find params[:id]
    match_session.master_exec code, 'Mestre'

    puts match_session.errors.to_json

    redirect_to gm_match_root_path(@game)
  end
end
