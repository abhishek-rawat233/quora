class RegistrationController < ApplicationController
  before_action :instantiate_user, only: :create
  include BaseUserConcern
  after_action :set_credits, only: :verification


  def new
    @user = BaseUser.new
  end

  def create
    if @user.save
      flash[:notice] = t('.successful')
    else
      flash[:notice] = t('.unsuccessful')
    end
    redirect_to signup_path
  end

  def verification
    @user = BaseUser.find(params[:id])
    redirect_to welcome_path, notice: t('.already_verified') if @user.verified
    if @user.verification_token == params[:token]
      @user.update(verified: true)
      render "verified"
    end
  end

  private
  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

#remove this
  # def field_empty?(*fields)
  #   fields.any? { |field| params[field].present? }
  # end

  def instantiate_user
    @user =  BaseUser.new(user_params)
  end
  end
