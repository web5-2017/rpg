class Profile::DashboardController < Profile::AppProfileController

  def search_users
    if params[:search] and !params[:search][:query].empty?
      @query = params[:search][:query]
      @users = User.where_name_like @query, current_user
    else
      @users = []
      @query = nil
    end
  end
end
