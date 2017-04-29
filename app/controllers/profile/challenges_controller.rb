class Profile::ChallengesController < Profile::AppProfileController
  before_action :find_game
  before_action :find_history
  before_action :find_challenge, except: [:index, :new, :create]

  def index
    @challenges = @game.challenges.all
  end

  def new
    @challenge = @game.challenges.new
    2.times do
      @challenge.alternatives.build
    end
  end

  def create
    @challenge = @game.challenges.new params_challenge
    @challenge.history = @history

    if @challenge.save
      flash[:success] = "Desafio criado com sucesso"
      redirect_to [:profile, @game, @history, @challenge]
    else
      flash[:error] = "Erro ao criar o desavio"
      render :new
    end
  end

  def update
    if @challenge.update params_challenge
      flash[:success] = "Desafio #{@challenge.name} atualizado com sucesso"
      redirect_to [:profile, @game, @history, @challenge]
    else
      puts @challenge.errors.to_json
      puts @challenge.history
      flash[:error] = "Erro ao atualizar o desafio #{@challenge.name}"
      render :new
    end
  end

  def destroy
    @challenge.destroy

    redirect_to action: :index
  end

  private

  def params_challenge
    params.require(:challenge).permit(:name, :description, alternatives_attributes: [:id, :content])
  end

  def find_history
    @history = @game.histories.find params[:history_id]
  end

  def find_game
    @game = current_user.games.find params[:game_id]
  end

  def find_challenge
    @challenge = @game.challenges.find params[:id]
  end
end
