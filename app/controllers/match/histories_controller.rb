class Match::HistoriesController < Match::AppMatchController
  def index
    @game = current_user.games.find params[:game_id]
    @histories = History.order :title
  end

  def my_histories
    @histories = current_user.histories.order :title
  end

  def show
    @history = History.find params[:id]
  end

  def new
    @history = current_user.histories.new
  end

  def create
    @history = current_user.histories.new history_params

    if @history.save
      flash[:success] = "A História #{@history.title} foi criada"
      redirect_to [:match, @history]
    else
      flash.now[:error] = "Tem um erro na criação da História"
      render :new
    end
  end

  def edit
    @history = current_user.histories.find params[:id]
  end

  def update
    @history = current_user.histories.find params[:id]

    if @history.update history_params
      flash[:success] = "A História #{@history.title} foi atualizada"
      redirect_to [:match, @history]
    else
      flash.now[:error] = "Tem um erro na atualização da História"
      render :new
    end
  end

  def destroy
    @history = current_user.histories.find params[:id]

    if @history.destroy
      flash[:success] = "História excluida"
      redirect_to action: :my_histories
    else
      flash[:error] = "História em uso"
      redirect_to action: :my_histories
    end
  end

  private

  def history_params
    params.require(:history).permit(:title, :content, :bootsy_image_gallery_id)
  end
end
