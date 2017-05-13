class Match::GameController < Match::AppMatchController

  def show
    @game = current_user.games_playing.find params[:id]
  end

end
