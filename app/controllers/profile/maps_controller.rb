class Profile::MapsController < Profile::AppProfileController
  before_action :find_history
  before_action :find_map, only: [:show, :edit, :update, :destroy]

  def index
    @maps = @history.maps.all
  end

  def new
    @map = @history.maps.new
  end

  def create
    @map = @history.maps.new map_params

    if @map.save
      @map.update_id_json
      flash.now[:success] = 'Mapa salvado'
      redirect_to [:profile, @history, @map]
    else
      falsh.now[:error] = 'Erro ao salvar o mapa'
      render :new
    end
  end

  def update
    if @map.update map_params
      flash.now[:success] = 'Mapa salvado'
      redirect_to [:profile, @history, @map]
    else
      falsh.now[:error] = 'Erro ao salvar o mapa'
      render :edit
    end
  end

  def destroy
    @map.destroy
    flash.now[:success] = 'Mapa deletado'
    redirect_to [:profile, @history]
  end

  private
  def map_params
    params.require(:map).permit(:name, :json_map, :rows, :columns)
  end

  def find_map
    @map = @history.maps.find params[:id]
  end

  def find_history
    @history = current_user.histories.find params[:history_id]
  end
end
