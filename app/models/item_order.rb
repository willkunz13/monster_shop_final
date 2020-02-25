class ItemOrder < ApplicationRecord
  validates_presence_of :item_id, :order_id, :price, :quantity

  belongs_to :item
  belongs_to :order

  enum status: ['unfulfilled', 'fulfilled']

  def subtotal
    price * quantity
  end

  def fulfill_order
    update(status: 1)
    require 'pry'; binding.pry
  end
end
