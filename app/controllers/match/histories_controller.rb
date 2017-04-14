class Match::HistoriesController < Match::AppMatchController
  layout '/layouts/application'

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

  private

  def history_params
    params.require(:history).permit(:title, :content, :bootsy_image_gallery_id)
  end
end
