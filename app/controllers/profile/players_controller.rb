class Profile::PlayersController < Profile::AppProfileController
  before_action :find_game

  def index
    @players = @game.players
  end

  def friend_list
    @users = current_user.friend_list
  end

  def adding_friend
    user = current_user.friend_list.find params[:id]
    @game.players << user

    redirect_to profile_game_friend_list_path(@game)
  end

  def removing_friend
    user = current_user.friend_list.find params[:id]
    @game.players.delete(user) if (@game.players.exists?(user.id))

    redirect_to profile_game_friend_list_path(@game)
  end

  private
  def find_game
    @game = current_user.games.find params[:game_id]
  end
end
