# controller that all controllers in the application reference
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from CanCan::AccessDenied do |exception|
    # flash[:error] = "Get The FuCK OUT"
    # redirect_to root_url
    # render :status => 404
    render file: 'public/404.html'
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :name, :password, :password_confirmation, :current_password, :description, :occupation) }
  end

  private

  def after_sign_in_path_for(resource_or_scope)
    dashboard_show_path
  end

  def after_sign_up_path_for(resource_or_scope)
    dashboard_show_path
  end
end
