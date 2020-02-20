require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'when I visit my user profile' do
    before :each do
      @user1 = User.create(
        name: 'Steve',
        address: '123 Street Road',
        city: 'City Name',
        state: 'CO',
        zip: 12_345,
        email: 'example@example.com',
        password: 'password1',
        role: 0
      )
    end

    it 'can see all of my information' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

      visit '/profile'

      within '#user_profile_info' do
        expect(page).to have_content('Name: Steve')
        expect(page).to have_content('Address: 123 Street Road')
        expect(page).to have_content('City Name CO, 12345')
        expect(page).to have_content('Email: example@example.com')
      end

      within '#user_buttons' do
        expect(page).to have_link('Edit')
      end
    end
  end
end
