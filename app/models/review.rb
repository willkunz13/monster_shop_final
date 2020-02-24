class Review < ApplicationRecord
	validates_inclusion_of :rating, in: 1..5

  belongs_to :item
end
