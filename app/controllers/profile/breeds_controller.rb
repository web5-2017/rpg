class Profile::BreedsController < Profile::AppProfileController
  before_action :find_game
  before_action :find_breed, only: [:show, :edit, :update, :destroy]

  def index
    @breeds = @game.breeds.all
  end

  def new
    @breed = @game.breeds.new
  end

  def create
    @breed = @game.breeds.new(breed_params)

    if @breed.save
      flash[:success] = "raça criada"
      redirect_to [:profile, @game, @breed]
    else
      flash[:error] = "erro ao criar a raça"
      render :new
    end
  end

  def update
    if @breed.update(breed_params)
      flash[:success] = "raça atualizada"
      redirect_to [:profile, @game, @breed]
    else
      flash[:success] = "erro ao atualizar a raça"
      render :edit
    end
  end

  def destroy
    @breed.destroy
    flash[:success] = "Raça apagada"
    redirect_to [:profile, @game]
  end

  private
    def find_game
      @game = current_user.games.find params[:game_id]
    end

    def find_breed
      @breed = @game.breeds.find(params[:id])
    end

    def breed_params
      params.require(:breed).permit(:name, :description, particular_ids: [])
    end
end
