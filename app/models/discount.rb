class Discount < ApplicationRecord
        belongs_to :merchant

        validates_presence_of :threshold, :percent
	validates :threshold, numericality: { greater_than: 0 }
	validates :percent, numericality: { greater_than: 0, less_than_or_equal_to: 100 }
end
