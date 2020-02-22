require 'rails_helper'

RSpec.describe 'As a USER', type: :feature do
  describe 'When I visit my profile page' do
    before :each do
      @user1 = User.create(
        name: 'Steve',
        address: '123 Street Road',
        city: 'City Name',
        state: 'CO',
        zip: 12345,
        email: 'example@example.com',
        password: 'password1',
        role: 0
      )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

      visit '/user/profile'
    end

    it 'I can see a link called MY ORDERS' do
      within "#user_buttons" do
        click_on 'My Orders'
      end

      expect(current_path).to eq('/user/profile/orders')
    end

    it 'can see orders on profile orders show page' do
      within "#user_buttons" do
        click_on 'My Orders'
      end

      expect(page).to have_content('')
    end
  end
end
