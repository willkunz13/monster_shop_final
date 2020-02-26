require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "Validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  describe "Relationships" do
		it {should belong_to :user}
    it {should have_many :item_orders}
    it {should have_many(:items).through(:item_orders)}
  end

  describe 'Instance methods' do
    before :each do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
			@user = User.create(name: 'Steve', address: '123 Street Road', city: 'City Name', state: 'CO', zip: 12345, email: 'example@example.com', password: 'password1', role: 0)

      @order_1 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user: @user)
      @order_2 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user: @user)
      @order_3 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user: @user)
      @order_4 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user: @user)

      @item_order_1 = @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
      @item_order_2 = @order_1.item_orders.create!(item: @pull_toy, price: @pull_toy.price, quantity: 3)
    end

    it 'grandtotal' do
      expect(@order_1.grandtotal).to eq(230)
    end

		it '.merchant_quantity' do
			expect(@order_1.merchant_quantity(@meg.id)).to eq(2)
		end

		it '.merchant_total' do
			expect(@order_1.merchant_total(@meg.id)).to eq(200)
    end

    it '.try_package' do
      expect(@order_1.status).to eq('pending')

      @order_1.item_orders.update(status: 1)
      @order_1.try_package
      expect(@order_1.status).to eq('packaged')
    end

    it '.item_count' do
      expect(@order_1.item_count).to eq(5)
    end

    it '.items_in_order' do
      expect(@order_1.items_in_order).to include(@tire)
      expect(@order_1.items_in_order).to include(@pull_toy)
    end

    it '.cancel' do
      @item_order_1.update(status: 1)
      @item_order_2.update(status: 1)
      expect(@order_1.status).to eq('pending')
      @order_1.cancel
      expect(@order_1.status).to eq('cancelled')

      expect(@item_order_1.status).to eq('unfulfilled')
      expect(@item_order_2.status).to eq('unfulfilled')
    end

    it '.sort_status' do
      @order_1.update(status: 0) # pending
      @order_2.update(status: 1) # packaged
      @order_3.update(status: 2) # shipped
      @order_4.update(status: 3) # cancelled

      expected = [@order_1, @order_2, @order_3, @order_4]

      expect(@user.orders.sort_status).to eq(expected) 
    end
  end
end
