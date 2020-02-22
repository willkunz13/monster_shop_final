class User::Profile::OrdersController < User::BaseController
	
	def index
		@orders = Order.where(user: current_user)
	end
end
