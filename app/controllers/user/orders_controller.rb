class User::OrdersController < ApplicationController
  def show
    @orders = current_user.orders.find(params[:id])
  end
end
