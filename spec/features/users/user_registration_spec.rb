require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'I can see a registration page' do
    it 'has a link to register' do
      visit '/merchants'

      within 'nav' do
        click_on 'Register'
      end

      expect(current_path).to eq('/register')
    end

    it 'can fill in info about a user' do
      visit '/register'

      within '#new_user_form' do
        fill_in :name, with: 'Oscar'
        fill_in :address, with: '123 Sesame Street'
        fill_in :city, with: 'New York'
        fill_in :state, with: 'Ohio'
        fill_in :zip, with: '44123'
        fill_in :email, with: 'example@pbs.com'
        fill_in :password, with: 'bigbird'
        fill_in :pass_confirm, with: 'bigbird'

        click_on 'Submit'
      end

      expect(current_path).to eq('/user/profile')
      expect(page).to have_content('You have successfully created a user.')
    end

    it 'cannot create a user without all information' do
      visit '/register'

      within '#new_user_form' do
        fill_in :name, with: 'Oscar'
        fill_in :address, with: '123 Sesame Street'
        fill_in :zip, with: '44123'
        fill_in :password, with: 'bigbird'
        fill_in :pass_confirm, with: 'bigbird'

        click_on 'Submit'
      end

      expect(current_path).to eq('/register')
      expect(page).to have_content("City can't be blank, State can't be blank")
    end

    it 'can save entries for an already entered email' do
      visit '/merchants'

      within 'nav' do
        click_on 'Register'
      end

      expect(current_path).to eq('/register')

      within '#new_user_form' do
        fill_in :name, with: 'Oscar'
        fill_in :address, with: '123 Sesame Street'
        fill_in :city, with: 'New York'
        fill_in :state, with: 'Ohio'
        fill_in :zip, with: '44123'
        fill_in :email, with: 'example@pbs.com'
        fill_in :password, with: 'bigbird'
        fill_in :pass_confirm, with: 'bigbird'

        click_on 'Submit'
      end

      visit '/merchants'

      within 'nav' do
        click_on 'Register'
      end

      within '#new_user_form' do
        fill_in :name, with: 'Oscar'
        fill_in :address, with: '123 Sesame Street'
        fill_in :city, with: 'New York'
        fill_in :state, with: 'Ohio'
        fill_in :zip, with: '44123'
        fill_in :email, with: 'example@pbs.com'
        fill_in :password, with: 'bigbird'
        fill_in :pass_confirm, with: 'bigbird'

        click_on 'Submit'
      end

      expect(page).to have_content 'Email has already been taken'
    end
  end
end
