class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :page_info_for_js
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def page_info_for_js
    gon.controller = params[:controller]
    gon.action = params[:action]
    if params[:action] == 'show' && params[:page]
      gon.page = params[:page]
    end
    if params[:action] == 'show' && params[:id]
      gon.id = params[:id]
    end
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username, :email, :password, :remember_me) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
    end
end
