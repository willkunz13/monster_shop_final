class OrdersController <ApplicationController

  def new
  end

  def show
  end

  def create
    order = Order.create(order_params)
    if order.save
      cart.items.each do |item,quantity|
        order.item_orders.create({
          item: item,
          quantity: quantity,
          price: correct_price(item, quantity)
          })
      end
      session.delete(:cart)
      flash[:notice] = "Your order was created as is currently pending"
      redirect_to "/user/profile/orders"
    else
      flash[:notice] = "Please complete address form to create an order."
      render :new
    end
  end


  private

  def order_params
	parmas =  params.permit(
		:name,
		:address,
		:city,
		:state,
		:zip
	).merge(user: current_user)
  end

	def correct_price(item, quantity)
		minimum = item.min_qualifier
                if minimum && quantity >= minimum
			item.max_discount_price(quantity)
		else
			item.price 
		end
	end
end
