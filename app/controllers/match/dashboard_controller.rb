class Match::DashboardController < Match::AppMatchController

  def index
    @char = current_user.characters.find_by game_id: @game.id

    if @char && !@char.new_character
      @match_session = @game.sessions.find_by closed: false
    else
      flash[:error] = "Para participar da partida você deve criar um personagem"
      redirect_to match_character_path(@game)
    end
  end

end
