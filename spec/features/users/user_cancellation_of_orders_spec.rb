require 'rails_helper'

RSpec.describe 'As a USER', type: :feature do
  describe 'When I visit my profile page' do
    before :each do
      @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80_203)
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80_203)
      @tire = @meg.items.create(name: 'Gatorskins', description: "They'll never pop!", price: 100, image: 'https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588', inventory: 12)
      @paper = @mike.items.create(name: 'Lined Paper', description: 'Great for writing on!', price: 20, image: 'https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png', inventory: 3)
      @pencil = @mike.items.create(name: 'Yellow Pencil', description: 'You can write on paper with it!', price: 2, image: 'https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg', inventory: 100)
      @user = User.create(
        name: 'Steve',
        address: '123 Street Road',
        city: 'City Name',
        state: 'CO',
        zip: 12345,
        email: 'example@example.com',
        password: 'password1',
        role: 0
      )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit "/items/#{@paper.id}"
      click_on 'Add To Cart'
      visit "/items/#{@paper.id}"
      click_on 'Add To Cart'
      visit "/items/#{@tire.id}"
      click_on 'Add To Cart'
      visit "/items/#{@pencil.id}"
      click_on 'Add To Cart'

      visit '/cart'
      click_on 'Checkout'

      name = 'Bert'
      address = '123 Sesame St.'
      city = 'NYC'
      state = 'New York'
      zip = 10001

      fill_in :name, with: name
      fill_in :address, with: address
      fill_in :city, with: city
      fill_in :state, with: state
      fill_in :zip, with: zip

      click_button 'Create Order'

      visit '/user/profile'

      within '#user_buttons' do
        click_on 'My Orders'
      end
    end

    it 'can see a cancel button on show page' do
      new_order = Order.last

      visit "/user/profile/orders/#{new_order.id}"

      click_on 'Cancel Order'

      expect(current_path).to eq('/user/profile')
      expect(page).to have_content('Order Cancelled')

      visit "/user/profile/orders/#{new_order.id}"

      expect(page).to have_content('cancelled')
    end

    it 'can see order as packaged if all items fulfilled' do
      new_order = Order.last

      new_order.item_orders.each do |item_order|
        item_order.fulfill
      end

      new_order.package_fulfilled

      visit "/user/profile/orders/#{new_order.id}"

      expect(page).to have_content('packaged')
      expect(page).to_not have_content('pending')
    end
  end
end
