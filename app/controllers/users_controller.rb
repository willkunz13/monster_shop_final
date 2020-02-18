class UsersController<ApplicationController

  def create
    if User.create(user_params)
      redirect_to '/profile'
      flash[:notice] = "Notice"
    end
  end


private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password, :role)
  end
end
