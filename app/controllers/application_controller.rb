class ApplicationController < ActionController::Base
  before_action :set_locale, :load_categories
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: User::PERMIT_ATTRIBUTES)
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def load_categories
    @categories = Category.active_status
  end
end
