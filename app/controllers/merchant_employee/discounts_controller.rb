class MerchantEmployee::DiscountsController< MerchantEmployee::BaseController
  
  def new
        end

  def create
	discount = Discount.new(discount_params)
	if discount.save
		redirect_to merchant_employee_dashboard_path
	else
		flash[:notice] = discount.errors.full_messages.to_sentence
		redirect_back(fallback_location: merchant_employee_dashboard_path)
	end
  end

  def edit
	@discount = Discount.find(params[:id])
  end

  def update
	discount = Discount.find(params[:id])
	discount.update(discount_params)
	if discount.save
		redirect_to merchant_employee_dashboard_path
	else
		flash[:notice] = discount.errors.full_messages.to_sentence
                redirect_back(fallback_location: merchant_employee_dashboard_path)
	end
  end

  def destroy
	Discount.destroy(params[:id])
	flash[:notice] = "Discount Deleted"
        redirect_back(fallback_location: merchant_employee_dashboard_path)
  end

  private

  def discount_params
	parmas =  params[:discount].permit(
                :threshold,
                :percent,
        ).merge(merchant: current_user.merchant)	
  end
end
