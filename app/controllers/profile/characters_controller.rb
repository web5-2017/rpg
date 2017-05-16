class Profile::CharactersController < Profile::AppProfileController
  before_action :find_game
  before_action :find_character, only: [:show, :edit, :update, :destroy]

  def index
    @characters = @game.characters.all
  end

  def new
    @character = @game.characters.new
    @breeds = @game.breeds.all
  end

  def edit
    @breeds = @game.breeds.all
  end

  def create
    @character = @game.characters.new(character_params)

    if @character.save
      flash[:success] = "personagem criado"
      redirect_to [:profile, @game, @character]
    else
      flash[:success] = "erro ao criar o personagem"
      render :new
    end
  end

  def update
    if @character.update(character_params)
      flash[:success] = "personagem atualizado"
      redirect_to [:profile, @game, @character]
    else
      flash[:success] = "erro ao atualizar o personagem"
      render :edit
    end
  end

  def destroy
    @character.destroy
    redirect_to [:profile, @game]
  end

  private
    def find_game
      @game = current_user.games.find params[:game_id]
    end

    def find_character
      @character = @game.characters.find(params[:id])
    end

    def character_params
      params.require(:character).permit(:name, :description, skill_ids: [], breed_ids: [])
    end
end
