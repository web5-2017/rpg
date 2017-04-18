class Match::CharactersController < Match::AppMatchController
  before_action :find_history
  before_action :find_character, only: [:show, :edit, :update, :destroy]

  def index
    @characters = @history.characters.all
  end

  def new
    @character = @history.characters.new
    @breeds = @history.breeds.all
  end

  def edit
    @breeds = @history.breeds.all
  end

  def create
    @character = @history.characters.new(character_params)

    if @character.save
      flash[:success] = "personagem criado"
      redirect_to [:match, @history, @character]
    else
      flash[:success] = "erro ao criar o personagem"
      render :new
    end
  end

  def update
    if @character.update(character_params)
      flash[:success] = "personagem atualizado"
      redirect_to [:match, @history, @character]
    else
      flash[:success] = "erro ao atualizar o personagem"
      render :edit
    end
  end

  def destroy
    @character.destroy
    redirect_to [:match, @history]
  end

  private
    def find_history
      @history = current_user.histories.find params[:history_id]
    end

    def find_character
      @character = @history.characters.find(params[:id])
    end

    def character_params
      params.require(:character).permit(:name, :description, skill_ids: [], breed_ids: [])
    end
end
