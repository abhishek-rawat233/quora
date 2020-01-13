class RegistrationController < ApplicationController
  skip_before_action :redirect_guest_users
  before_action :redirect_current_user
  before_action :set_user, only: [:create]
  before_action :get_user_by_id, only: :verification
  before_action :redirect_pre_verified_user, only: :verification


  def new
    @user = User.new
  end

  def create
    if @user.save
      flash[:notice] = t('.user_creation_successful')
      redirect_to login_path
    else
      flash[:notice] = t('.user_creation_unsuccessful')
      redirect_to signup_path
    end
  end

  def verification
    if @user.verification_token == params[:token]
      @user.verify
      redirect_to login_path, notice: t('.verification_successful')
    else
      redirect_to login_path, notice: t('.invalid_url')
    end
  end

  private

  def redirect_pre_verified_user
    redirect_to login_path, notice: t('.already_verified') if @user.verified
  end

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user =  User.new(user_params)
  end
end
