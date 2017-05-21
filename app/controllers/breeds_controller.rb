class BreedsController < ApplicationController

  def show
    game = Game.find params[:game_id]
    breed = game.breeds.find params[:id]
    render json: breed.characters
  end
end
