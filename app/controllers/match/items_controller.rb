class Match::ItemsController < Match::AppMatchController
  before_action :find_game
  before_action :find_item, except: [:index, :new, :create]

  def index
    @items = @game.items
  end

  def new
    @item = @game.items.new
  end

  def create
    @item = @game.items.new items_params

    if @item.save
      flash[:success] = "Item criado com sucesso"
      redirect_to [:match, @game, @item]
    else
      flash.now[:error] = "Erro ao criar o item"
      render :new
    end
  end

  def edit
    @item = @game.items.find params[:id]
  end

  def update
    if @item.update items_params
      flash[:success] = "Item #{@item.name} atualizado"
      redirect_to [:match, @game, @item]
    else
      flash.now[:error] = "Erro ao atualizar o item"
      render :edit
    end
  end

  def destroy
    @item.destroy

    redirect_to match_game_items_path(@game)
  end

  private
  def find_game
    @game = current_user.games.find params[:game_id]
  end

  def find_item
    @item = @game.items.find params[:id]
  end

  def items_params
    params.require(:item).permit(:name, :description, :effect_id)
  end
end
