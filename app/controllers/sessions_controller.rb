class SessionsController < ApplicationController
  skip_before_action :redirect_guest_users, except: :welcome
  before_action :redirect_current_user, only: [:new, :login, :forgot_password, :forgot_password_form, :reset_password_form, :reset_password_form]
  before_action :get_user_by_email, only: [:forgot_password, :login]
  before_action :check_user_validity, only: :login
  before_action :get_user_by_id, only: [:reset_password_form, :reset_password]

  def new
    @user = User.new
  end

  def login
    remember_me?
    redirect_unverified_user
    session[:api_token] = @user.api_token
    redirect_to user_home_path(@user)
  end

  def redirect_unverified_user
    redirect_to login_url, notice: t('.unverified') unless @user.verified
  end

  def logout
    flash[:notice] = t('application.logout.logout')
    logout
  end

  def forgot_password
    if @user.present?
      @user.set_forgot_password_token
    else
      redirect_to login_path, notice: t('.user_not_present')
    end
  end

  def reset_password_form
    render 'invalid_url' unless @user.present? && @user.forgot_password_token == params[:token]
  end

  def reset_password
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
    cookies.permanent.signed[:api_token] = @user.api_token if params[:remember_me]
  end
end
