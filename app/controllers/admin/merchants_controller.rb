class Admin::MerchantsController < Admin::BaseController

	def index
		@merchants = Merchant.all
	end

	def show
		@merchant = Merchant.find(params[:merchant_id])
	end
end
