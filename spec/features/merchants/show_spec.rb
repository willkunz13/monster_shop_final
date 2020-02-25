require 'rails_helper'

RSpec.describe 'merchant show page' do
  describe 'As a user' do
    before :each do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
			@merchant = @bike_shop.users.create!(name: "Merchant", address: "123 merchant ave.", city: "City of Townsville", state: "Nv", zip: "39433", email: "merchant@gmail.com", password: "merchant", role: 1)

			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)

			visit "/merchants/#{@bike_shop.id}"
    end

    it 'I can see a merchants name, address, city, state, zip' do

      expect(page).to have_content("Brian's Bike Shop")
      expect(page).to have_content("123 Bike Rd.\nRichmond, VA 23137")
    end

    it 'I can see a link to visit the merchant items' do

      expect(page).to have_link("All #{@bike_shop.name} Items")

      click_on "All #{@bike_shop.name} Items"

      expect(current_path).to eq("/merchant_employee/merchants/#{@bike_shop.id}/items")
    end
  end
end
