class ProfileController < ApplicationController
  before_action :authenticate_user!
  
  layout '/layouts/profile/application'
end
