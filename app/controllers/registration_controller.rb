class RegistrationController < ApplicationController
  before_action :set_user, only: [:create]
  before_action :get_user_by_id, only: :verification

  def new
    @user = BaseUser.new
  end

  def create
    if @user.save
      flash[:notice] = t('.user_creation_successful')
    else
      flash[:notice] = t('.user_creation_unsuccessful')
    end
    redirect_to signup_path
  end

  def verification
    if @user.nil?
      redirect_to signup_path, notice: t('.contact_help')
    elsif @user.verified
      redirect_to login_path, notice: t('.already_verified')
    elsif @user.verification_token == params[:token]
      @user.verify
      render "verified"
    else
      redirect_to login_path, notice: t('.invalid_url')
    end
  end

  private
  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user =  User.new(user_params)
  end
end
