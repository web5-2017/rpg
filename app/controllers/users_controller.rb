class UsersController < ApplicationController
  before_action :authenticate_user!

  def update
    if current_user.id == params[:id].to_i
      if current_user.update params.require(:user).permit(:avatar)
        flash[:success] = "Imagem atualizada"
      else
        flash[:error] = "Erro ao atualizar a imagem"
      end
    end

    redirect_to controller: :profile, action: :index
  end
end
