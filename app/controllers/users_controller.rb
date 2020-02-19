class UsersController<ApplicationController


	def new
	end

	def show
		@user = User.find(params[:id])
	end
  def create
    user = User.new(user_params)
	if user.save
      redirect_to "/profile/#{user.id}"
      flash[:notice] = "You are now registered and logged in"
    else
	flash[:error] = @item.errors.full_messages.to_sentence
	render :new
	end
  end


private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password, :role)
  end
end
