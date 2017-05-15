class Match::AppMatchController < ::ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :find_game

  layout '/layouts/match/application'

  private
  def find_game
    if is_a? Match::GameController
      @game = current_user.games_playing.find params[:id]
    else
      @game = current_user.games_playing.find params[:game_id]
    end
  end
end
