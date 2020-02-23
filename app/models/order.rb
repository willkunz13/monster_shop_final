class Order <ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip

	belongs_to :user
  has_many :item_orders
  has_many :items, through: :item_orders

  def grandtotal
    item_orders.sum('price * quantity')
  end

  def item_count
    items.sum(:quantity)
  end

  def items_in_order
    items
  end

  def cancel
    update(status: 'cancelled')

    item_orders.each do |order|
      order.update(status: 'unfulfilled')
      order.item.update(inventory: (order.item.inventory + order.quantity))
    end
  end

  def self.sort_status
    order(status: :ASC)
  end

  def packaged?
    true unless self.status != 'packaged'
  end

  # def package_fulfilled
  #   update(status: 'packaged') if item_orders.distinct.pluck(:status) == 'fulfilled'
  # end
end
