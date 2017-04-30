class Profile::UsersController < Profile::AppProfileController

  def update
    if current_user.id == params[:id].to_i
      if current_user.update params.require(:user).permit(:avatar)
        flash[:success] = "Imagem atualizada"
      else
        flash[:error] = "Erro ao atualizar a imagem"
      end
    end

    redirect_to profile_edit_path
  end

  def adding_friend
    user = User.find params[:user_id]
    current_user.friend_list << user unless(user == current_user and current_user.friend_list.exists?(user))

    redirect_to profile_search_users_path(search: { query: params[:search][:query]})
  end
end
