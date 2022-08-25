class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if current_user
      #mail to user when signin
      UserMailer.sign_in(current_user).deliver_later

      render json: { message: "#{current_user.name.capitalize}! You are logged In!! Role: #{current_user.role.capitalize}" }, status: :ok
    else
      render json: { message: "not logged in. " }, status: :unprocessable_entity
    end
  end

  def respond_to_on_destroy
    log_out_success && return if current_user

    log_out_failure
  end

  def log_out_success
    render json: { message: "You are logged out." }, status: :ok
  end

  def log_out_failure
    render json: { message: "Hmm nothing happened." }, status: :unauthorized
  end
end
