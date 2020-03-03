require 'rails_helper'
  
RSpec.describe 'As a User' do
  describe "When I check out from my cart" do
    before(:each) do
	@mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
      @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
      @user = User.create(name: 'Steve', address: '123 Street Road', city: 'City Name', state: 'CO', zip: 12345, email: 'example@example.com', password: 'password1', role: 0)
      @discount = Discount.create(threshold: 10, percent: 20, merchant: @meg)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit item_path(@paper)
      click_on "Add To Cart"
      visit item_path(@paper)
      click_on "Add To Cart"
      visit item_path(@tire)
      click_on "Add To Cart"
      visit item_path(@pencil)
      click_on "Add To Cart"
      visit '/cart'
    end

	it 'shows discounts' do
		expect(page).to_not have_content("Discount: 20.0%")
		within "#cart-item-#{@tire.id}" do
                	click_on "+1"
			click_on "+1"
			click_on "+1"
			click_on "+1"
			click_on "+1"
			click_on "+1"
			click_on "+1"
			click_on "+1"
			click_on "+1"	
			expect(page).to have_content("Discount: 20.0%")
			expect(page).to have_content("Subtotal: $800.00")
                end
	end

	it 'create discount orders' do
		within "#cart-item-#{@tire.id}" do
			10.times {click_on "+1"}
		end
		click_on "Checkout"
		name = "Bert"
	      address = "123 Sesame St."
	      city = "NYC"
	      state = "New York"
	      zip = 10001

	      fill_in :name, with: name
	      fill_in :address, with: address
	      fill_in :city, with: city
	      fill_in :state, with: state
	      fill_in :zip, with: zip

	      click_button "Create Order"
		expect(page).to have_content("922.00")
      	  end
	end
end
		

