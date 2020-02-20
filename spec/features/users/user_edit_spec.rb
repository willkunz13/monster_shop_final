require 'rails_helper'

RSpec.describe 'As a USER', type: :feature do
  describe 'When I click the edit link' do
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

    it 'allows me to edit my profile' do
      within "#user_buttons" do
        click_on 'Edit'
      end
    end
  end
end
