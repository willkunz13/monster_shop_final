require 'rails_helper'

RSpec.describe 'As an Admin' do
	describe 'When I visit the merchants index page.' do
		before :each do
			@megs_shop = Merchant.create!(name: "Meg's Dog Shop", address: '123 Dog Rd.', city: 'Hershey', state: 'PA', zip: 80203)
			@brians_shop = Merchant.create!(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

			@admin = User.create!(name: "Admin", address: "123 Admin cir.", city: "The provinance of holeville", state: "Ca", zip: "83845", email: "admin@gmail.com", password: "admin", role: 2)
			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
	 	end

		it 'I see a list of all the Merchants on the website and there names are a hyperlink to their dashborads.' do

			visit "/admin/merchants"

			expect(current_path).to eq("/admin/merchants")

			expect(page).to have_content(@megs_shop.name)
			expect(page).to have_content(@brians_shop.name)

			within "#merchant-#{@megs_shop.id}" do
				expect(page).to have_link(@megs_shop.name)

				click_on "#{@megs_shop.name}"

				expect(current_path).to eq("/admin/merchants/#{@megs_shop.id}")
			end
		end
	end
end
