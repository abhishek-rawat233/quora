class RegistrationController < ApplicationController
  # before_action :confirm_password, only: [:create, :update]

  def create
    # debugger
    @user =  User.new(user_params)
    if @user.save
      VerificationMailer.verify(@user, verificationUrl).deliver
      flash[:notice] = "User successfully registered. Please verify email using link send"
    else
      flash[:notice] = 'User registration unsuccessful.'
    end
    redirect_to registration_index_path
  end

  def verification
    debugger
  end

  private
  def confirm_password
    unless params[:password].empty? && params[:password] == params[:password_confirmation]
      redirect_to registration_index_path, notice: 'password didnot match'
    end
  end

  def user_params
    params[:verification_token] = params[:email].hash.to_s
    params.permit(:email, :password, :verification_token)
  end

  def verificationUrl
    # url_for 'link', verification_path(id: @user.id, token: @user.verification_token )
    link_to 'link', verification_path(id: @user.id, token: @user.verification_token )
  end
end
