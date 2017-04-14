class Match::GamesController < Match::AppMatchController

  def index
    @games = current_user.games.order :name
  end

  def show
    @game = current_user.games.find params[:id]
    @histories = @game.histories.order :title
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

  def add_history
    history = History.find params[:history_id]
    game = current_user.games.find params[:game_id]
    game.histories << history

    flash[:success] = "#{history.title} adicionada a partida"
    redirect_to match_game_histories_path(game)
  end

  def remove_history
    history = History.find params[:history_id]
    game = current_user.games.find params[:game_id]
    game.histories.destroy(history)

    flash[:success] = "#{history.title} removida da partida"
    redirect_to [:match, game]
  end

  private

  def game_params
    params.require(:game).permit(:name)
  end
end
