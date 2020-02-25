class MerchantEmployee::ItemStatusController < MerchantEmployee::BaseController
	def update
		item = Item.find(params[:id])
		if item.active?
			item.update(active?: false)
			flash[:notice] = "#{item.name}, has been Deactivated."
		else
			item.update(active?: true)
			flash[:notice] = "#{item.name}, has been Activated."
		end
		redirect_back(fallback_location: '/merchant_employee/dashboard')
	end
end
