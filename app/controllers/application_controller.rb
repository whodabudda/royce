class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters  , if: :devise_controller?
  before_action :authenticate_admin! , only: [:new,:create,:edit,:destroy,:update]
 # devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :password_confirmation) } 
def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:email) }
  devise_parameter_sanitizer.permit(:update) { |u| u.permit( :email, :password, :password_confirmation, :current_password)}
end
end
