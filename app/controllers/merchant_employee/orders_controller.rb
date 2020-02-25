class MerchantEmployee::OrdersController < ApplicationController
	
  def show
    merchant = current_user.merchant
    @order = merchant.orders.find(params[:id])
    @item_orders = merchant.item_orders.where(order: @order)
  end
end
