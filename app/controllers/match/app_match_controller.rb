class Match::AppMatchController < ::ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  layout :layout_feature

  protected

  def layout_feature
    puts action_for_layout.include?("#{controller_name}##{action_name}")
    return '/layouts/application' if action_for_layout.include?("#{controller_name}##{action_name}")

    '/layouts/profile/application'
  end

  def action_for_layout
    ['histories#new', 'histories#edit', 'histories#show', 'maps#new', 'maps#edit']
  end
end
