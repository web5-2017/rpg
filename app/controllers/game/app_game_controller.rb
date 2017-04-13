class Game::AppGameController < ::ActionController::Base
  protect_from_forgery with: :exception
  layout '/layouts/profile/application'

end
