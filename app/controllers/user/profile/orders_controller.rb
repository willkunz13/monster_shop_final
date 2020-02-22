class User::Profile::OrdersController < User::BaseController
	
	def index
		@orders = Order.where(user: current_user)
	end

	def show
    @orders = current_user.orders.find(params[:id])
  end
end
