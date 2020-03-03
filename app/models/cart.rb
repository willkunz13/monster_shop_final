class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents
  end

  def add_item(item_id)
    @contents[item_id] = 0 if !@contents[item_id]
    @contents[item_id] += 1
  end

  def total_items
    @contents.values.sum
  end

  def items
    item_quantity = {}
    @contents.each do |item_id,quantity|
      item_quantity[Item.find(item_id)] = quantity
    end
    item_quantity
  end

  def subtotal(item)
    if discounted?(item)
	discounted_price(item)
    else
	item.price * @contents[item.id.to_s]
    end
  end

  def total
    @contents.sum do |item_id,quantity|
      item = Item.find(item_id)
	if discounted?(item)
       	   discounted_price(item)
	else
	   item.price * quantity
	end
    end
  end

	def limit_reached?(item_id)
		@contents[item_id] == Item.find(item_id).inventory
        end

	def add_quantity(item_id)
		add_item(item_id)
	end

	def subtract_quantity(item_id)
		@contents[item_id] = 0 if !@contents[item_id]
    		@contents[item_id] -= 1
	end

	def quantity_zero?(item_id)
		@contents[item_id] == 0
	end

	def current_quantity(item)
		contents[item.id.to_s]
	end

	def discounted?(item)
		minimum = item.min_qualifier
		if minimum
			current_quantity(item) >= minimum
		else
			false
		end
	end

	def discount_percentage(item)
		item.discount_percentage(current_quantity(item))
	end

	def discounted_price(item)
		quantity = current_quantity(item)
		item.max_discount_price(quantity) * quantity	
	end
end

