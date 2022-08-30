# frozen_string_literal: true

# module
module Users
  # registration
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters, if: :devise_controller?
    def create
      return not_authorized unless current_user # if the role of the current login user is admin then only create a user

      if current_user.role == 'admin'
        if check_user_params
          build_resource(sign_up_params)
          resource.save
          yield resource if block_given?
          if resource.persisted?
            if resource.active_for_authentication?
              UserMailer.welcome(resource).deliver_later # mail to new user created by admin
              set_flash_message! :notice, :signed_up
              sign_up(resource_name, resource)
              respond_with resource, location: after_sign_up_path_for(resource)
            else
              set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
              expire_data_after_sign_in!
              respond_with resource, location: after_inactive_sign_up_path_for(resource)
            end
          else
            clean_up_passwords resource
            set_minimum_password_length
            respond_with resource
          end
        else
          wrong_params
        end
      else
        register_failed # else send registration failed or not authorize message
      end
    end

    respond_to :json

    #   ---------------------------------------------------------------------------------
    include RackSessionFix    # fix 505 error internal server error  session diable

    private

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[name role])
    end

    def respond_with(resource, _opts = {})
      register_success && return if resource.persisted?

      register_failed
    end

    def register_success
      render json: { message: 'Register  Sucessfully.' }
    end

    def register_failed
      render json: { message: 'Only Admin Can Create New User' }
    end

    def not_authorized
      render json: { message: 'You are not authorized for it!' }
    end
  end
end
