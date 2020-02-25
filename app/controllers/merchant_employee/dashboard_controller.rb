class MerchantEmployee::DashboardController< MerchantEmployee::BaseController
	
  def show
		@merchant = current_user.merchant
	end
end
