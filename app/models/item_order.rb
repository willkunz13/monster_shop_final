class ItemOrder < ApplicationRecord
  validates_presence_of :item_id, :order_id, :price, :quantity

  belongs_to :item
  belongs_to :order

  enum status: ['unfulfilled', 'fulfilled']

  def subtotal
    price * quantity
  end

  def can_fulfill?
    quantity <= item.inventory
  end

  def fulfill
    update(status: 1)
  end
end
