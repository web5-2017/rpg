class PicturesController < ApplicationController
  before_action :authenticate_user!

  def index
    @pictures = Picture.all
    @picture = Picture.new
  end

  def create
    @picture = Picture.new params.require(:picture).permit(:image)
    @picture.save

    render json: @picture.to_json
  end
end
