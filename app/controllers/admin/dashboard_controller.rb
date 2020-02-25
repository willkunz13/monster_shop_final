class Admin::DashboardController < Admin::BaseController

  def show
    @orders = Order.sort_status
  end
end
