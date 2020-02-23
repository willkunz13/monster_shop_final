require 'rails_helper'

RSpec.describe 'As a Merchant Employee' do
	describe 'When I log in I am sent to my Dashboard' do
		before :each do
			@dog_shop = Merchant.create(name: "Meg's Dog Shop", address: '123 Dog Rd.', city: 'Hershey', state: 'PA', zip: 80203)
			@meg = @dog_shop.users.create!(name: "Meg", address: "123 merchant ave.", city: "City of Townsville", state: "Nv", zip: "39433", email: "meg@gmail.com", password: "merchant", role: 1)
			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@meg)
		end

		it 'Where I see the name and address of my Employer' do

			visit '/merchant/dashboard'

			expect(current_path).to eq("/merchant/dashboard")

			within "#employer" do
				expect(page).to have_content(@dog_shop.name)
				expect(page).to have_content(@dog_shop.address)
				expect(page).to have_content(@dog_shop.city)
				expect(page).to have_content(@dog_shop.state)
				expect(page).to have_content(@dog_shop.zip)
			end
		end
	end
end
