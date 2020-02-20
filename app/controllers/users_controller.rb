class UsersController < ApplicationController
  def new
    @new_user = User.new(user_params)
  end

  def create
    new_user = User.new(user_params)

    if new_user.save
      redirect_to '/profile'
      session[:user_id] = new_user.id
      flash[:notice] = 'You have successfully created a user.'
    else
      flash[:notice] = new_user.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    @user = current_user
  end

  private

  def user_params
    params.permit(
      :name,
      :address,
      :city,
      :state,
      :zip,
      :email,
      :password,
      :role
    )
  end
end
