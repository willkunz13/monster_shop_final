require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "I can see a registration page" do
    it "has a form to fill in" do
      visit '/merchants'

      within 'nav' do
        click_on 'Register'
      end

      expect(current_path).to eq('/register')

      fill_in :name, with: 'Oscar'
      fill_in :address, with: '123 Sesame Street'
      fill_in :city, with: 'New York'
      fill_in :state, with: 'Ohio'
      fill_in :zip, with: '44123'
      fill_in :email, with: 'example@pbs.com'
      fill_in :password, with: 'bigbird'
      fill_in :pass_confirm, with: 'bigbird'
	within "#register" do
		click_on "Register"
	end
	profile = User.last
	expect(current_path).to eq("/profile/#{profile.id}")
	expect(page).to have_content("You are now registered and logged in")
    end

	it "can refute bad credentials" do
		 visit '/merchants'

	      within 'nav' do
		click_on 'Register'
	      end

	      expect(current_path).to eq('/register')

	      fill_in :name, with: 'Oscar'
	      fill_in :address, with: '123 Sesame Street'
	      fill_in :state, with: 'Ohio'
	      fill_in :zip, with: '44123'
	      fill_in :email, with: 'example@pbs.com'
	      fill_in :password, with: 'bigbird'
	      fill_in :pass_confirm, with: 'bigbird'
		within "#register" do
			click_on "Register"
		end
		expect(page).to have_content("blah")
	end
	it "can save entries for an already entered email" do
		 visit '/merchants'

	      within 'nav' do
		click_on 'Register'
	      end

	      expect(current_path).to eq('/register')

	      fill_in :name, with: 'Oscar'
	      fill_in :address, with: '123 Sesame Street'
		fill_in :city, with: 'New York'
	      fill_in :state, with: 'Ohio'
	      fill_in :zip, with: '44123'
	      fill_in :email, with: 'example@pbs.com'
	      fill_in :password, with: 'bigbird'
	      fill_in :pass_confirm, with: 'bigbird'
		within "#register" do
			click_on "Register"
		end
		 visit '/merchants'
	      within 'nav' do
		click_on 'Register'
	      end

	      fill_in :name, with: 'Oscar'
	      fill_in :address, with: '123 Sesame Street'
		fill_in :city, with: 'New York'
	      fill_in :state, with: 'Ohio'
	      fill_in :zip, with: '44123'
	      fill_in :email, with: 'example@pbs.com'
	      fill_in :password, with: 'bigbird'
	      fill_in :pass_confirm, with: 'bigbird'
		within "#register" do
			click_on 'Register'
		end
		expect(page).to have_content ("Oscar")	
	end
		
  end
end
#
# User Story 10, User Registration
#
# As a visitor
# When I click on the 'register' link in the nav bar
# Then I am on the user registration page ('/register')
# And I see a form where I input the following data:
# - my name
# - my street address
# - my city
# - my state
# - my zip code
# - my email address
# - my preferred password
# - a confirmation field for my password
#
# When I fill in this form completely,

# And with a unique email address not already in the system

# My details are saved in the database

# Then I am logged in as a registered user

# I am taken to my profile page ("/profile")

# I see a flash message indicating that I am now registered and logged in
