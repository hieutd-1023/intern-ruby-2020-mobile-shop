class AdminsController < ApplicationController
  include SessionsHelper
  before_action :check_admin

  layout "admins"

  def check_admin
    redirect_to root_path if current_user&.role != Settings.admin
  end
end
