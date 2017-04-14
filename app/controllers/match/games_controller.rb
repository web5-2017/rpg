class Match::GamesController < Match::AppMatchController

  def index
    @games = current_user.games.order :name
  end

  def show
    @game = current_user.games.find params[:id]
    @histories = @game.histories.order :name
  end

  def new
    @game = current_user.games.new
  end

  def create
    @game = current_user.games.new game_params

    if @game.save
      flash[:success] = "partida criada"
      redirect_to [:match, @game]
    else
      flash.now[:error] = "erro ao criar a partida"
      render :new
    end
  end

  private

  def game_params
    params.require(:game).permit(:name)
  end
end
