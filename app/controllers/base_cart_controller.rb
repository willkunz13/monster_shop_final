class BaseCartController < ApplicationController
  before_action :require_user

  def require_user
    render file: "/public/404" unless (current_user? || current_merchant_employee?)
  end
end
