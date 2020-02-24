class Admin::StatusChangeController < Admin::BaseController

  def update
    merchant = Merchant.find(params[:id])

    if merchant.enabled?
      merchant.update(enabled?: false)
      flash[:notice] = "Account for #{merchant.name} is now DISABLED."
      redirect_to '/admin/merchants'
    else
      merchant.update(enabled?: true)
      flash[:notice] = "Account for #{merchant.name} is now ENABLED."
      redirect_to '/admin/merchants'
    end
  end

end
