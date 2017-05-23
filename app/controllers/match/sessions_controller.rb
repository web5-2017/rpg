class Match::SessionsController < Match::AppMatchController

  def run_code
    char = current_user.characters.find_by game_id: @game.id
    code = params[:code]

    if char && !char.new_character
      match_session = @game.session.find params[:id]
      match_session.player_exec code, char.name

      redirect_to match_root_path(@game)
    else
      flash[:error] = "Para participar da partida você deve criar um personagem"
      redirect_to match_character_path(@game)
    end
  end
end
