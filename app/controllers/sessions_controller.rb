class SessionsController < ApplicationController
  before_action :redirect_guest_users, only: [:welcome]
  before_action :redirect_current_user, only: :new
  before_action :get_user_by_email, only: [:forgotPassword, :login]
  before_action :get_user_by_id, only: [:resetPasswordForm, :reset_password]

  def new
    @user = User.new
  end

  def login
    unless @user.present? && @user.validate_password(params[:password])
      redirect_to login_url, notice: t('.authentication_failure')
    else
      remember_me?
      unless @user.verified
        redirect_to login_url, notice: t('.unverified')
      end
      session[:user_id] = @user.id
      redirect_to home_path
      # redirect_to welcome_path
    end
  end

  def destroy
    if cookies.signed[:api_token].present?
      cookies.signed[:api_token] = nil
    end
    session[:user_id] = nil
    redirect_to login_path, notice: t('.logout')
  end

  def forgotPasswordForm
  end

  def forgotPassword
    if @user.present?
      @user.set_forgot_password_token
    else
      redirect_to login_path, notice: t('.user_not_present')
    end
  end

  def resetPasswordForm
    render 'invalid_url' unless user.present? && @user.forgot_password_token == params[:token]
  end

  def reset_password()
    if password_matched?
      @user.update_password(params[:password])
      @user.set_api_token
      redirect_to login_path, notice: t('.reset_successful')
    else
      flash[:notice] = t('.password_not_matched')
    end
  end

  def welcome
  end

  def password_matched?
    params[:password] == params[:password_confirmation]
  end

  def remember_me?
    if params[:remember_me]
      cookies.permanent.signed[:api_token] = @user.api_token
    end
  end

  def redirect_current_user
    redirect_to welcome_path if @current_user.present?
  end
end
