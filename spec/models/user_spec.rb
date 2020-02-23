require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
    it {should validate_presence_of :email}
    it {should validate_presence_of :password}

    it {should validate_uniqueness_of :email}
  end

	describe "Relationships" do
		it {should have_many :orders}
		it {should belong_to(:merchant).optional}
	end

  describe "Roles" do

    it "can be created as an admin" do
			admin = User.create(name: 'Steve', address: '123 Street Road', city: 'City Name', state: 'CO', zip: 12345, email: 'example@example.com', password: 'password1', role: 2)

      expect(admin.role).to eq("admin")
      expect(admin.admin?).to be_truthy
    end

    it "can be created as a default user" do
			user = User.create(name: 'Steve', address: '123 Street Road', city: 'City Name', state: 'CO', zip: 12345, email: 'example@example.com', password: 'password1', role: 0)

      expect(user.role).to eq("default")
      expect(user.default?).to be_truthy
    end
  end
end
