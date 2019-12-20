class RegistrationController < ApplicationController
  before_action :instantiate_user, only: [:create]
  include UserConcern
  after_action :set_credits, only: :verification


  def new
    @user = User.new
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
    @user = User.find(params[:id])
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

  def field_empty?(*fields)
    fields.any? { |field| params[field].present? }
  end

  def instantiate_user
    @user =  User.new(user_params)
  end
end
