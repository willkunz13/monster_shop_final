class Admin::DashboardController < Admin::BaseController
  def index
    @orders = Order.sort_status
  end
end
