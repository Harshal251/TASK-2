class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_user, only: %i[ show update destroy ]

  # GET /users
  def index
    if current_user
      @users = User.all
      render json: { users: @users }
      # @users = User.where.not(role1: 1) if user_student
      # @users = User.where(role1: 1) if user_teacher
      # @users = User.all if user_admin
      # @users1 = User.where(role1: 0) if user_teacher

      #     if user_teacher
      #               render json: { student: @users1, teacher: @users }
      #     else
      #           render json: {users: @users }
      #     end
    else
      render json: { message: "Login first as admin and then access this page." }, status: :unprocessable_entity
    end
  end

  # GET /users/1
  def show
    render json: user_details
    # return render json: { user: user_info } if able_to_show
  end

  # POST /users
  def create
    if current_user.role == "admin"
      @user = User.new(user_params)
      @user.save
      render json: @user, status: :created, location: @user
    else
      render plain: @user.errors.full_messages
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: { message: "User Details Updated Successfully!!" }
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    render json: user_destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:email, :role, :name)
  end

  def user_destroy
    data = []
    data << {
      message: "User Details Destroyed Successfully",
      user_id: @user.id,
      user_name: @user.name,
      Role: @user.role,
    }
    return data
  end

  def user_details
    data = []
    data << {
      user_id: @user.id,
      user_name: @user.name,
      Role: @user.role,
    }
    return data
  end
end
