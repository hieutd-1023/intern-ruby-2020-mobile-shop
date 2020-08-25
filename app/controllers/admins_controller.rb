class AdminsController < ApplicationController
  load_and_authorize_resource
  check_authorization

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  layout "admins"
end
