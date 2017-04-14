class Match::AppMatchController < ::ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  layout :layout_feature

  protected

  def layout_feature
    return '/layouts/application' if self.is_a? Match::HistoriesController and action_name != 'index'

    '/layouts/profile/application'
  end
end
