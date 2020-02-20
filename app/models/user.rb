class User < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, :email, :password
  validates :password, confirmation: { case_sensitive: true }

  validates_uniqueness_of :email

  has_secure_password

  enum role: ["default", "merchant_employee", "admin"]
end
