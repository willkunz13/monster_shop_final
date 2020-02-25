class Admin::MerchantsController < Admin::BaseController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
  end

  def update
    merchant = Merchant.find(params[:id])
    if merchant.enabled?
      merchant.update(status: 1)
      merchant.items.update_all(active?: false)
      flash[:notice] = "Account for #{merchant.name} is now DISABLED."
    else
      merchant.update(status: 0)
      merchant.items.update_all(active?: true)
      flash[:notice] = "Account for #{merchant.name} is now ENABLED."
    end
    redirect_back(fallback_location: '/admin/merchants')
  end
end
