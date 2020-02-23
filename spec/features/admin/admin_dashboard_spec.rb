require 'rails_helper'

RSpec.describe 'As an ADMIN', type: :feature do
  describe 'When I do visit my dashboard' do
    before :each do
      @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80_203)
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80_203)
      @tire = @meg.items.create(name: 'Gatorskins', description: "They'll never pop!", price: 100, image: 'https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588', inventory: 12)
      @paper = @mike.items.create(name: 'Lined Paper', description: 'Great for writing on!', price: 20, image: 'https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png', inventory: 3)
      @pencil = @mike.items.create(name: 'Yellow Pencil', description: 'You can write on paper with it!', price: 2, image: 'https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg', inventory: 100)
      @user1 = User.create(
        name: 'Steve',
        address: '123 Street Road',
        city: 'City Name',
        state: 'CO',
        zip: 12345,
        email: 'example1@example.com',
        password: 'password1',
        role: 0
      )

      @user2 = User.create(
        name: 'Sebastian',
        address: '123 Street Road',
        city: 'City Name',
        state: 'CO',
        zip: 12345,
        email: 'example2@example.com',
        password: 'password1',
        role: 0
      )

      @user3 = User.create(
        name: 'Will',
        address: '123 Street Road',
        city: 'City Name',
        state: 'CO',
        zip: 12345,
        email: 'example3@example.com',
        password: 'password1',
        role: 0
      )

      @admin = User.create(
        name: 'Kevin',
        address: '123 Street Road',
        city: 'City Name',
        state: 'CO',
        zip: 12345,
        email: 'admin@example.com',
        password: 'password1',
        role: 2
      )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      @order_1 = @user1.orders.create!(name: @user1.name, address: 'address', city: 'city', state: 'state', zip: 12345, status: 'cancelled')
      @order_2 = @user2.orders.create!(name: @user2.name, address: 'address', city: 'city', state: 'state', zip: 12345, status: 'packaged')
      @order_3 = @user3.orders.create!(name: @user3.name, address: 'address', city: 'city', state: 'state', zip: 12345, status: 'pending')
    end

    it 'I can see all orders in the system' do
      visit '/admin/dashboard'

      within "#order-#{@order_1.id}" do
        expect(page).to have_link('Steve')
        expect(page).to have_content(@order_1.id)
        expect(page).to have_content(@order_1.created_at.to_date)
      end

      within "#order-#{@order_2.id}" do
        expect(page).to have_link('Steve')
        expect(page).to have_content(@order_2.id)
        expect(page).to have_content(@order_2.created_at.to_date)
      end

      within "#order-#{@order_3.id}" do
        expect(page).to have_link('Steve')
        expect(page).to have_content(@order_3.id)
        expect(page).to have_content(@order_3.created_at.to_date)
      end
    end
  end
end
