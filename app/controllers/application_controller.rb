class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  helper_method :cart, :current_user, :current_admin?, :current_merchant?, :current_default?, :defaults, :merchants, :admins, :discounts

  def cart
    @cart ||= Cart.new(session[:cart] ||= Hash.new(0))
  end

	def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
 	end

	def current_admin?
    current_user && current_user.admin?
  end

  def current_merchant?
    current_user && current_user.merchant_employee?
  end

  def current_default?
    current_user&.default?
  end

	def defaults
		User.where(role: 'default')
	end

	def merchants
		User.where(role: 'merchant_employee')
	end

	def admins
		User.where(role: 'admin')
	end
	
	def discounts
		Discount.where("#{current_user.merchant.id} = merchant_id") 
	end
end
