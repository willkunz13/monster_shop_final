require 'rails_helper'

describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
    it {should validate_presence_of :email}
    it {should validate_presence_of :password}

    it {should validate_uniqueness_of :email}
  end
	describe "relationships" do
		it {should have_many :orders}
		it {should have_many :users}
	end

  describe "roles" do
    it "can be created as an admin" do
      user = User.create(name: "penelope",
                          address: "123 W",
                          city: "a",
                          state: "IN",
                          zip: 12345,
                          email: "a",
                         password: "boom",

                         role: 2)

      expect(user.role).to eq("admin")
      expect(user.admin?).to be_truthy
    end

    it "can be created as a default user" do
      user = User.create(name: "penelope",
                          address: "123 W",
                          city: "a",
                          state: "IN",
                          zip: 12345,
                          email: "a",
                         password: "boom",

                         role: 0)



      expect(user.role).to eq("default")
      expect(user.default?).to be_truthy
    end
  end
end
