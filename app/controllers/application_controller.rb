class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    	devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :name, :password, :password_confirmation, :current_password, :description, :occupation) }
    end

   # def index
    # Use flash for some nice messaging support
    #flash.notice = "Notice: You reached a new page "
   # flash[:error] = "Error: You reached a broken page"
    #flash[:warning] =  "Warning: Problem loading data"

  private

    def after_sign_in_path_for(resource_or_scope)
      dashboard_dashboard_main_path
    end

    def after_sign_up_path_for(resource_or_scope)
      dashboard_dashboard_main_path
    end

end
