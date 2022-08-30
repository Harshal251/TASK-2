# frozen_string_literal: true

# User_mailer
class UserMailer < ApplicationMailer
  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Car Parking Management Api!!')
  end

  def sign_in(user)
    @user = user
    mail(to: @user.email, subject: 'Login Sucess!!')
  end
end
