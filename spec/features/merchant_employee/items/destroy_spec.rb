require 'rails_helper'

RSpec.describe 'item delete' do
  describe 'when I visit an item show page' do
		before :each do
			@bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
			@chain = @bike_shop.items.create!(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
			@tire = @bike_shop.items.create!(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
			@review_1 = @chain.reviews.create!(title: "Great place!", content: "They have great bike stuff and I'd recommend them to anyone.", rating: 5)
			@merchant = @bike_shop.users.create!(name: "Merchant", address: "123 merchant ave.", city: "City of Townsville", state: "Nv", zip: "39433", email: "merchant@gmail.com", password: "merchant", role: 1)
			@user = User.create!(name: 'Steve', address: '123 Street Road', city: 'City Name', state: 'CO', zip: 12345, email: 'example@example.com', password: 'password1', role: 0)
			@order_1 = Order.create!(name: 'Meg', address: '123 Stang St', city: 'Hershey', state: 'PA', zip: 80218, user: @user)
			@order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)

			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)

			visit "/merchant_employee/merchants/#{@bike_shop.id}/items/#{@chain.id}"
		end

    it 'I can delete an item' do

      expect(page).to have_link("Delete Item")

      click_on "Delete Item"

      expect(current_path).to eq("/merchant_employee/merchants/#{@bike_shop.id}/items")
      expect("item-#{@chain.id}").to be_present
    end

    it 'I can delete items and it deletes reviews' do

      click_on "Delete Item"
      expect(Review.where(id:@review_1.id)).to be_empty
    end

    it 'I can not delete items with orders' do
			visit "/merchant_employee/merchants/#{@bike_shop.id}/items/#{@tire.id}"

      expect(page).to_not have_link("Delete Item")
    end
  end
end
