class GmMatch::AppGmMatchControllerController < ::ActionController::Base
  protect_from_forgery with: :exception
  before_action :find_game
  layout '/layouts/gm_match/application'

  protected

  def find_game
    begin
      @game = current_user.games.find params[:game_id]
    rescue ActiveRecord::RecordNotFound => e
      puts e.message
      render file: 'public/404.html',
             status: :not_found,
             layout: false
    end
  end
end
