class ApplicationController < ActionController::API
  before_action :authenticate_user!

  def check_user_params
    params[:user].present?
  end

  # include ::ActionController::Cookies

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role, :email, :password, :name])
    # devise_parameter_sanitizer.permit(:floors, keys: [:Floor_No,:User_Id])

  end

  #  def show_info(response)
  #   render json: response, status: 200
  # end
end
