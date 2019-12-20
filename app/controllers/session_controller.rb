class SessionController < ApplicationController
  include UserConcern
  after_action :set_forgot_password_token, :send_reset_password_mail, only: :forgotPassword
  after_action :destroy_password_token, only: :reset_password

  def new
    redirect_to welcome_path if @current_user
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user.try(:authenticate, params[:password])
      if params[:remember_me]
        set_remember_login_token(@user)
        cookies.permanent.signed[:user_id] = @user.id
        cookies.permanent.signed[:remember_login_token] = @user.remember_login_token
      end
      redirect_to login_url, notice: 'Only verified users can login. Please VERIFY' unless @user.verified
      session[:user_id] = @user.id
      redirect_to welcome_path
    else
      redirect_to login_url, notice: 'Invalid Email/Password combination.'
    end
  end

  def destroy
    if cookies.signed[:user_id]
      cookies.signed[:user_id] = nil
      cookies.signed[:remember_login_token] = nil
    end
    session[:user_id] = nil
    redirect_to login_path, notice: "Logged out"
  end

  def forgotPasswordForm
  end

  def forgotPassword
  end

  def resetPasswordForm
    @user = User.find_by(id: params[:user_id])
    render 'invalid_url' unless @user.forgot_password_token == params[:token]
  end

  def reset_password()
    user = User.find_by(id: params[:user_id])
    if password_matched?
      user.update(password: params[:password])
      redirect_to login_path, notice: 'Password successfully reset.'
    else
      flash[:notice] = "please enter same password in both field."
    end
  end

  def welcome
    redirect_to login_path if @current_user.nil?
  end

  def password_matched?
    params[:password] == params[:password_confirmation]
  end
end
