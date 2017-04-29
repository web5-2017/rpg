class Profile::BreedsController < Profile::AppProfileController
  before_action :find_history
  before_action :find_breed, only: [:show, :edit, :update, :destroy]

  def index
    @breeds = @history.breeds.all
  end

  def new
    @breed = @history.breeds.new
  end

  def create
    @breed = @history.breeds.new(breed_params)

    if @breed.save
      flash[:success] = "raça criada"
      redirect_to [:profile, @history, @breed]
    else
      flash[:error] = "erro ao criar a raça"
      render :new
    end
  end

  def update
    if @breed.update(breed_params)
      flash[:success] = "raça atualizada"
      redirect_to [:profile, @history, @breed]
    else
      flash[:success] = "erro ao atualizar a raça"
      render :edit
    end
  end

  def destroy
    @breed.destroy
    flash[:success] = "Raça apagada"
    redirect_to [:profile, @history]
  end

  private
    def find_history
      @history = current_user.histories.find params[:history_id]
    end

    def find_breed
      @breed = @history.breeds.find(params[:id])
    end

    def breed_params
      params.require(:breed).permit(:name, :description, particular_ids: [])
    end
end
