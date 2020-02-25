class MerchantEmployee::OrdersController < ApplicationController
  def show
    merchant = current_user.merchant
    @order = merchant.orders.find(params[:id])
    @item_orders = merchant.item_orders.where(order: @order)
  end

  def fulfill
    merchant = current_user.merchant
    require 'pry'; binding.pry
    order = merchant.orders.find(params[:id])
    item_orders = merchant.item_orders.where(order: order)

  end
end
