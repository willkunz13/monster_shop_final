class Admin::OrdersController < Admin::BaseController
  def index

  end

  def show
    user = User.find(params[:id])
    @order = user.orders.find(params[:id])
  end
end
