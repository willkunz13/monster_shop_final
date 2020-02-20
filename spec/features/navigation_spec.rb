
require 'rails_helper'

RSpec.describe 'Site Navigation' do
  describe 'As a Visitor' do
    it "I see a nav bar with links to all pages" do
      visit '/merchants'

      within 'nav' do
        click_link 'All Items'
      end

      expect(current_path).to eq('/items')

      within 'nav' do
        click_link 'All Merchants'
      end

      expect(current_path).to eq('/merchants')

#      within 'nav' do
#      click_link 'Home'
#      end

#      expect(current_path).to eq('/')
    end

    it "I can see a cart indicator on all pages" do
      visit '/merchants'

      within 'nav' do
        expect(page).to have_content("Cart: 0")
      end

      visit '/items'

      within 'nav' do
        expect(page).to have_content("Cart: 0")
      end

    end
  end

	describe 'As a User' do
		it "I see profile and log out" do
			user = User.create(name: "penelope",
                          address: "123 W",
                          city: "a",
                          state: "IN",
                          zip: 12345,
                          email: "a",
                         password: "boom",
                         role: 0)
			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

			visit '/merchants' 
		      within 'nav' do
			click_link 'Profile'
		      end

		      expect(current_path).to eq('/user/profile')
#		      within 'nav' do
#			click_link 'Logout'
#		      end
#			expect(page).to have_content("You have logged out, or whatever")
#		      expect(current_path).to eq('/')
		end
	end
	
	describe 'As a Merchant Employee' do
                it "I see normal nav stuff and link to merchant dashboard" do
                        merchant = User.create(name: "penelope",
                          address: "123 W",
                          city: "a",
                          state: "IN",
                          zip: 12345,
                          email: "a",
                         password: "boom",
                         role: 1)
                        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)
			
                        visit '/merchants'
                      within 'nav' do
                        click_link 'Profile'
                      end

                      expect(current_path).to eq('/user/profile')
			within 'nav' do
				click_link 'Merchant Dashboard'
			end
			expect(current_path).to eq("/merchant/dashboard")
#                     within 'nav' do
#                       click_link 'Logout'
#                     end
#                       expect(page).to have_content("You have logged out, or whatever")
#                     expect(current_path).to eq('/')
                end
        end

	describe 'As an Admin' do
                it "I see normal nav stuff and link to admin dashboard and all users" do
                        admin = User.create(name: "penelope",
                          address: "123 W",
                          city: "a",
                          state: "IN",
                          zip: 12345,
                          email: "a",
                         password: "boom",
                         role: 2)
                        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
                        
                        visit '/merchants'
                      within 'nav' do  
                        click_link 'Profile'
                      end

                      expect(current_path).to eq('/user/profile')
                        within 'nav' do
                                click_link 'Admin Dashboard'
                        end
                        expect(current_path).to eq("/admin/dashboard")
			within 'nav' do
				click_link 'See All Users'
			end
			expect(current_path).to eq("/admin/users")
#                     within 'nav' do
#                       click_link 'Logout'
#                     end
#                       expect(page).to have_content("You have logged out, or whatever")
#                     expect(current_path).to eq('/')
                end
        end

end
