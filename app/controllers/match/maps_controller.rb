class Match::MapsController < Match::AppMatchController

  def index
    @history = current_user.histories.find params[:history_id]
  end

  def new
    @history = current_user.histories.find params[:history_id]
  end
end
