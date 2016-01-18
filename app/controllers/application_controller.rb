class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include ApplicationHelper

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :authenticate_user!

  def authorize(object = nil)
    owner = object.owner || User.new
    return if owner == current_user || (owner.contributors.include?(current_user) && current_user.contributors.include?(owner))
    flash[:error] = 'You dont have permission to access this section'
    redirect_to root_url
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :username, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :email, :username, :password, :password_confirmation, :current_password) }
  end
end
