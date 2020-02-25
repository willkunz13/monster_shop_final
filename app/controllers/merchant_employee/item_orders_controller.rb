class MerchantEmployee::ItemOrdersController < MerchantEmployee::BaseController
  def update
    item_order = ItemOrder.find(params[:id])

    require 'pry'; binding.pry
    if item_order.can_fulfill?
      item_order.fulfill
    else
      flash[:notice] = "You do not have enough inventory to fulfill that item."
    end

    redirect_back(fallback_location: '/merchant_employee/orders')
  end
end
