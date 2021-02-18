class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private
  def record_not_found
    render file: "#{Rails.root}/public/404.html",
           status: :not_found,
           layout: false
  end
  #devise sign up add permit
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
 
end
