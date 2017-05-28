class Match::CharactersController < Match::AppMatchController
  before_action :find_character, only: [:show, :update, :edit, :save_attrs]

  def show
  end

  def new
    @character = current_user.characters.new game_id: @game.id
    @breeds = @game.breeds
    @picture = Picture.new
    @pictures = Picture.all
  end

  def create
    @character = current_user.characters.new params_user_character
    @character.game_id = @game.id

    if @character.save
      flash[:success] = "Personagem criado"
      redirect_to match_character_path(@game)
    else
      @breeds = @game.breeds
      flash.now[:error] = "Erro ao criar o personagem"
      render :new
    end
  end

  def update
    if @character.update params_user_character
      flash[:success] = "Personagem atualizado"
      redirect_to match_character_path(@game)
    else
      flash.now[:error] = "Erro ao atualizar o personagem"
      render :new
    end
  end

  def save_attrs
    if @character.new_character || !@character.confirmed_attributes
      @character.update params_attr
      flash[:success] = "Atributos atualizados"
    end

    redirect_to match_character_path(@game)
  end

  private
  def find_character
    @character = current_user.characters.find_by game_id: @game.id
  end

  def params_user_character
    params.require(:user_character).permit(:name, :history, :character_id, :breed_id)
  end

  def params_attr
    params.require(:character_attrs).permit(:str, :dex, :con, :int, :wis, :confirmed_attributes,
                                        :cha, :hp, :atk, :def, :mp, :magic_atk, :magic_def, :new_character)
  end
end
