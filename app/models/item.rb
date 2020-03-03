class Item < ApplicationRecord
	validates_presence_of :name, :description, :price, :inventory
	validates_numericality_of :price, greater_than: 0

  belongs_to :merchant
  has_many :reviews, dependent: :destroy
  has_many :item_orders
  has_many :orders, through: :item_orders

  def average_review
    reviews.average(:rating)
  end

  def sorted_reviews(limit, order)
    reviews.order(rating: order).limit(limit)
  end

  def no_orders?
    item_orders.empty?
  end

  def self.most_popular(limit)
    joins(:item_orders)
    .group(:id)
    .order('SUM(item_orders.quantity)DESC')
    .limit(limit)
  end

  def self.least_popular(limit)
    joins(:item_orders)
    .group(:id)
    .order('SUM(item_orders.quantity)ASC')
    .limit(limit)
  end

  def quantity_ordered
    item_orders.sum(:quantity)
  end

  def quantity_by_order(order_id)
    item_orders.where(order_id: order_id).sum(:quantity)
  end

  def subtotal(order_id)
    quantity_by_order(order_id) * price
  end

  def min_qualifier
    merchant.discounts.minimum(:threshold)
  end

  def discount_percentage(quantity)
    merchant.discounts.where("threshold <= ?", quantity).maximum(:percent)
  end

  def max_discount_price(quantity)
	merchant_id = merchant.id
	item_id = self.id
	Merchant.all.joins(:items, :discounts).where("threshold <= ? AND merchants.id = ? AND items.id = ?", quantity, merchant_id, item_id).pluck('items.price  * (1 - discounts.percent/ 100)').min
  end

end
