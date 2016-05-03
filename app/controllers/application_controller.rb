class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  include ApplicationHelper

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :set_quote
  before_filter :set_locale

  def default_url_options
    { locale: I18n.locale }
  end

  def authorize(object = nil)
    owner = object.owner || User.new
    return if current_user.admin? || owner == current_user || (owner.contributors.include?(current_user) && current_user.contributors.include?(owner))
    flash[:error] = 'You dont have permission to access this section'
    redirect_to root_url
  end

  def admin_only
    redirect_to :root, alert: 'Access denied.' unless current_user.admin?
  end

  protected

  def set_quote
    @random_quote = Quote.random
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :username, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :email, :username, :password, :password_confirmation, :current_password, :role) }
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    @language = I18n.locale
  end
end
