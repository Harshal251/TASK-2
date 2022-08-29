class ApplicationController < ActionController::API
  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActionDispatch::Request::Session::DisabledSessionError, with: :render_session_disabled
rescue_from CanCan::AccessDenied ,with: :render_access_denied_response
  def render_unprocessable_entity_response(exception)
    render json: exception.record.errors, status: :unprocessable_entity
  end

  def render_not_found_response(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def render_session_disabled
    render json: { error: exception.message }, status: 500
  end
  def render_access_denied_response
    render json:{message: "Login First to Access!!"},status: 500
  end

  def routing_error(error = "Routing error", status = :not_found, exception = nil)
    # render_exception(404, "Routing Error", exception)
    render json: {
             message: "Please Check Your Routes!!",
           # exception: :exception
           }, status: :not_found
  end

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
