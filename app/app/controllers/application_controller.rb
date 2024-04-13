class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
  
    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:role_type, :member_id, :trainer_id, :staff_id])
    end
  end
  