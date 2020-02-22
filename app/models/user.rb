class User < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, :email, :password_digest

  validates_uniqueness_of :email

	has_many :orders
  has_secure_password

  enum role: ["default", "merchant_employee", "admin"]

  after_initialize :set_defaults

  private

  def set_defaults
    if self.new_record?
      self.role ||= 'default'
    end
  end
end
