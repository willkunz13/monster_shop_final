require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'when I visit my user profile' do
    before :each do
      @user1 = User.create(
        name: 'Steve',
        address: '123 Street Road',
        city: 'City Name', state: 'CO',
        zip: 12345,
        email: 'example@example.com',
        password: 'password1',
        role: 0
      )
    end

    it 'can see all of my information' do

    end
  end
end
