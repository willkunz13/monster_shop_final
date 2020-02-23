class Admin::OrdersController < Admin::BaseController
  def index
  end

  def show
    user = User.find(params[:id])
    @order = user.orders.find(params[:id])
  end

  def ship
    order = Order.find(params[:id])
    order.update(status: 'shipped')
    redirect_to admin_dashboard_path
  end
end
