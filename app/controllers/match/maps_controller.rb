class Match::MapsController < Match::AppMatchController
  before_action :find_history

  def index
    @maps = @history.maps.all
  end

  def new
    @map = @history.maps.new
  end

  def edit
    @map = @history.maps.find params[:id]
  end

  def create
    @map = @history.maps.new map_params

    if @map.save
      @map.update_id_json
      flash.now[:success] = 'Mapa salvado'
      redirect_to edit_match_history_map_path @history, @map
    else
      falsh.now[:error] = 'Erro ao salvar o mapa'
      render :new
    end
  end

  def update
    @map = @history.maps.find params[:id]

    if @map.update map_params
      flash.now[:success] = 'Mapa salvado'
      redirect_to edit_match_history_map_path @history, @map
    else
      falsh.now[:error] = 'Erro ao salvar o mapa'
      render :edit
    end
  end

  private
  def map_params
    params.require(:map).permit(:json_map, :rows, :columns)
  end

  def find_history
    @history = current_user.histories.find params[:history_id]
  end
end
