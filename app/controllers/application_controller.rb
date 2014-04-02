class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  after_filter :store_location

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :name, :email, :password, :password_confirmation, :invite_code) }
  end

  def store_location
    if (request.fullpath != "/login" &&
        request.fullpath != "/user/login" &&
        request.fullpath != "/register" &&
        request.fullpath != "/user/register" &&
        request.fullpath != "/password" &&
        request.fullpath != "/logout" &&
        request.fullpath != "/user/logout" &&
        request.fullpath != "/user" &&
        request.fullpath != "/admin/login" &&
        request.fullpath != "/admin/register" &&
        request.fullpath != "/admin/password" &&
        request.fullpath != "/admin/logout" &&
        request.fullpath != "/admin" &&
        request.fullpath != "/" &&
        !request.xhr?)
      session[:previous_url] = request.fullpath
    end
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || haircuts_path
  end
end
