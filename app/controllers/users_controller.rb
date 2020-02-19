class UsersController < ApplicationController
  def new; end

  def create
    new_user = User.create(user_params)

    if new_user.save
      redirect_to "/profile/#{new_user.id}"
      flash[:notice] = 'You have successfully created a user.'
    else
      redirect_to '/register'
      flash[:notice] = 'Missing Required Fields.'
    end
  end

  def show; end

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
