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
    unless @user.present? && @user.try(:authenticate, params[:password])
      redirect_to login_url, notice: t('.authentication_failure')
    else
      remember_me?
      unless @user.verified
        redirect_to login_url, notice: t('.unverified')
      end
      session[:user_id] = @user.id
      redirect_to welcome_path
    end
  end

  def destroy
    if cookies.signed[:user_id]
      cookies.signed[:user_id] = nil
      cookies.signed[:remember_login_token] = nil
    end
    session[:user_id] = nil
    redirect_to login_path, notice: t('.logout')
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
      redirect_to login_path, notice: t('.reset_successful')
    else
      flash[:notice] = t('.password_not_matched')
    end
  end

  def welcome
    redirect_to login_path if @current_user.nil?
  end

  def password_matched?
    params[:password] == params[:password_confirmation]
  end

  def remember_me?
    if params[:remember_me]
      set_remember_login_token(@user)
      cookies.permanent.signed[:user_id] = @user.id
      cookies.permanent.signed[:remember_login_token] = @user.remember_login_token
    end
  end
end
