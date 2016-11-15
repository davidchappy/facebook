class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, :if => :devise_controller?
  protect_from_forgery with: :exception

  private

    def after_sign_out_path_for(resource_or_scope)
      root_path
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) do |user_params|
        user_params.permit({ roles: [] }, :name, :email, :password, :password_confirmation)
      end   
      devise_parameter_sanitizer.permit(:account_update) do |user_params|
        user_params.permit({ roles: [] }, :name, :email, :password, 
                                          :password_confirmation, :current_password)
      end
      devise_parameter_sanitizer.permit(:sign_in) do |user_params|
        user_params.permit({ roles: [] }, :email, :password)
      end 
    end

end
