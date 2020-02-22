class User::Profile::OrdersController < User::BaseController
	
	def index
		@orders = Order.where(user: current_user)
	end

	def show
    @order = current_user.orders.find(params[:id])
  end
end
