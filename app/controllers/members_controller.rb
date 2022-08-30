# if we are logged_in this the information that will be shown
class MembersController < ApplicationController
  before_action :authenticate_user!

  def show 
    render json:{
      message: "If You see this, you are in!!"
      user: user
    }
  end
  
end