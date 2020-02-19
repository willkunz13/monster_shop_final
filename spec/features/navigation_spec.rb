
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
 
      within 'nav' do
        click_link 'home'
      end

      expect(current_path).to eq('/')
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
			visit '/merchants' 
		      within 'nav' do
			click_link 'profile'
		      end

		      expect(current_path).to eq('/profile')
		      within 'nav' do
			click_link 'logout'
		      end
			expect(page).to have_content("You have logged out, or whatever")
		      expect(current_path).to eq('/')
		end
	end
end
