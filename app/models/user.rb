class User < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, :email, :password_digest

  validates_uniqueness_of :email

  has_secure_password

  enum role: ["default", "merchant_employee", "admin"]
end
