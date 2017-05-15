class Match::BreedsController < Match::AppMatchController

  def show
    breed = @game.breeds.find params[:id]

    render json: breed.characters
  end
end
