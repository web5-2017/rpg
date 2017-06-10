class GmMatch::CharactersController < GmMatch::AppGmMatchControllerController
  before_action :set_character, except: [:index, :new, :create]
  before_action :set_type
  before_action :set_breeds, only: [:new, :edit, :create, :update]

  def index
    @characters = current_user.characters.where(game_id: params[:game_id], character_type: params[:type])
  end

  def new
    @character = current_user.characters.new
  end

  def edit
    @classes = @character.breed.characters
  end

  def create
    @character = current_user.characters.new_for_type params[:type], character_new_params
    if @character.save
      flash[:success] = "#{@type} #{@character.name} criado com sucesso"
      redirect_to gm_match_character_path(@game.id, @type, @character.id)
    else
      @classes = @character.breed.characters if @character.breed
      flash.now[:error] = "Erro ao criar o #{@type}"
      render :new
    end
  end

  def update
    if @character.update character_edit_params
      flash[:success] = "#{@type} #{@character.name} atualizado com sucesso"
      redirect_to gm_match_character_path(@game.id, @type, @character.id)
    else
      @classes = @character.breed.characters
      flash.now[:error] = "Erro ao atualizar o #{@type}"
      render :edit
    end
  end

  def destroy
    @character.destroy
    flash[:success] = "#{@type} deletado com sucesso"

    redirect_to gm_match_characters_path(@game, @type)
  end

  private

  def set_character
    @character = current_user.characters.find params[:id]
  end

  def set_type
    @type = params[:type]

    if @type != 'npc' and @type != 'mob'
      render file: 'public/404.html',
             status: :not_found,
             layout: false
    end
  end

  def set_breeds
    @breeds = @game.breeds
  end

  def character_new_params
    params.require(:user_character).permit(:name,
                                           :history,
                                           :breed_id,
                                           :character_id,
                                           :game_id,
                                           :level,
                                           :str,
                                           :dex,
                                           :con,
                                           :int,
                                           :wis,
                                           :cha,
                                           :atk,
                                           :magic_atk,
                                           :def,
                                           :magic_def,
                                           :hp,
                                           :mp)
  end

  def character_edit_params
    params.require(:user_character).permit(:name,
                                           :history,
                                           :game_id,
                                           :level,
                                           :str,
                                           :dex,
                                           :con,
                                           :int,
                                           :wis,
                                           :cha,
                                           :atk,
                                           :magic_atk,
                                           :def,
                                           :magic_def,
                                           :hp,
                                           :mp)
  end
end
