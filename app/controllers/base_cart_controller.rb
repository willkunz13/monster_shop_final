class BaseCartController < ApplicationController
  before_action :require_user
  def require_user
    # require 'pry'; binding.pry
    render file: "/public/404" if current_admin?
  end
end
