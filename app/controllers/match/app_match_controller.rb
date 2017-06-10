class Match::AppMatchController < ::ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :find_game

  layout '/layouts/match/match_application'

  private
  def find_game
    begin
      @game = current_user.games_playing.find params[:game_id]
    rescue ActiveRecord::RecordNotFound => e
      puts e.message
      render file: 'public/404.html',
             status: :not_found,
             layout: false
    end
  end
end
