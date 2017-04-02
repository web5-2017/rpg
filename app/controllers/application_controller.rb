class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  layout :layout_feature

  protected

  def layout_feature
    return 'devise/devise_layout' if devise_controller?

    'application'
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:name, :email, :password, :password_confirmation)
    end

    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit(:name, :age, :email, :password, :password_confirmation, :current_password)
    end
  end
end
