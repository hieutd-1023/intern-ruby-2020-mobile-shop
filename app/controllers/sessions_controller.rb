class SessionsController < ApplicationController
  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate(params[:session][:password])
      log_in user
      redirect_to root_path
    else
      flash[:warning] = t ".failed_login"
      redirect_to root_url
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
