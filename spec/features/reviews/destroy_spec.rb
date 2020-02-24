require 'rails_helper'

RSpec.describe 'As a User' do
	describe "when I visit the item show page." do
		describe "I see options to delete a review." do
  		before(:each) do
    		@bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    		@chain = @bike_shop.items.create!(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
				@review_1 = @chain.reviews.create!(title: "Great place!", content: "They have great bike stuff and I'd recommend them to anyone.", rating: 5)
			
				visit "/items/#{@chain.id}"
  		end

    	it "I can see a link next to each review to delete it" do

        within "#review-#{@review_1.id}" do
          expect(page).to have_link("Delete")
        end
      end

    	it "I can delete a review when I click on delete" do

      	within "#review-#{@review_1.id}" do
        	click_on "Delete"
      	end

      	expect(current_path).to eq("/items/#{@chain.id}")
      	expect(page).to_not have_css("#review-#{@review_1.id}")
    	end
  	end
	end
end
