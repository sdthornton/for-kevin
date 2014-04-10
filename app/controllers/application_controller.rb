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
        request.fullpath != "/register" &&
        request.fullpath != "/logout" &&
        request.fullpath != "/" &&
        request.fullpath !~ /admin/i &&
        request.fullpath !~ /user/i &&
        !request.xhr?)
      session[:previous_url] = request.fullpath

      puts request.fullpath
      puts session[:previous_url]
    end
  end

  def after_sign_in_path_for(resource)
    if cookies[:show_haircut] && session[:previous_url] !~ /haircut/
      haircut = Haircut.find_by(url: cookies[:show_haircut])
      page = (Haircut.ordered.pluck('member').index(haircut.member) / 20) + 1
      haircuts_path(page: page)
    else
      session[:previous_url] || haircuts_path
    end
  end

  # Add custom flash types
  add_flash_types :successful_bid
end
