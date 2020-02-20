class SessionsController < ApplicationController

	def new
    if current_default?
		  flash[:notice] = "You are already logged in as #{current_user.name}, to log out please select 'Log Out' at the top of your page."
			redirect_to "/profile"
		end
	end

	# def new
	# 	if current_admin?
  #     redirect_to "/admin/dashboard"
  #     flash[:notice] = "You are already logged in as #{current_user.name}, to log out please select 'Log Out' at the top of your page."
  #   elsif current_merchant?
  #     redirect_to "/merchant/dashboard"
  #     flash[:notice] = "You are already logged in as #{current_user.name}, to log out please select 'Log Out' at the top of your page."
  #   elsif current_default?
  #     redirect_to "/profile"
  #     flash[:notice] = "You are already logged in as #{current_user.name}, to log out please select 'Log Out' at the top of your page."
	# 	end
	# end

	def create
		user = User.find_by(email: params[:email])
		if user != nil && user.authenticate(params[:password])
			session[:user_id] = user.id
			flash[:success] = "#{user.name}, has been successfully logged in!"
			redirect_to '/profile'
		else
			flash.now[:notice] = "Your Log in attempt failed, Wrong email or password"
			render :new
		end
	end

	# def create
	# 	user = User.find_by(email: params[:email])
	# 	if user != nil && user.authenticate(params[:password])
	# 		session[:user_id] = user.id
	# 		flash[:success] = "#{user.name}, has been successfully logged in!"
	# 		if user.admin?
	# 			redirect_to '/admin/dashboard'
	# 			flash[:success] = "#{user.name}, has been successfully logged in!"
	# 		elsif user.merchant?
	# 			redirect_to '/merchant/dashboard'
	# 			flash[:success] = "#{user.name}, has been successfully logged in!"
	# 		else user.default?
	# 			redirect_to '/profile'
	# 			flash[:success] = "#{user.name}, has been successfully logged in!"
	# 		end
	# 	else
	# 		flash.now[:notice] = "Your Log in attempt failed, Wrong email or password"
	# 		render :new
	# 	end
	# end

	def destroy
    session.delete(:user_id)
    session.delete(:cart)
    flash[:success] = "You have been successfully logged out!!"
    redirect_to "/welcome"
	end
end
