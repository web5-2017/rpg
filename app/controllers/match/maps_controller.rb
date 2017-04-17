class Match::MapsController < Match::AppMatchController
  before_action :find_history

  def new
    @map = @history.maps.new
  end

  def create
    @map = @history.maps.new map_params

    if @map.save
      @map.update_id_json
      flash.now[:success] = 'Mapa salvado'
    else
      falsh.now[:error] = 'Erro ao salvar o mapa'
    end
  end

  def update
    @map = @history.maps.find id

    if @map.update map_params
      flash.now[:success] = 'Mapa salvado'
    else
      falsh.now[:error] = 'Erro ao salvar o mapa'
    end
  end

  private
  def id
    params.require(:map).permit(:id)
  end

  def map_params
    params.require(:map).permit(:json_map, :rows, :columns)
  end

  def find_history
    @history = current_user.histories.find params[:history_id]
  end
end
