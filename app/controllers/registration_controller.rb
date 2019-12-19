class RegistrationController < ApplicationController
  # before_action :confirm_password, only: [:create, :update]
  include UserConcern
  after_action :set_credits, only: :verification


  def new
    @user = User.new
  end

  def create
    @user =  User.new(user_params)
    if @user.save
      UserMailer.verify(@user).deliver_later
      flash[:notice] = "User successfully registered. Please verify email using link send"
    else
      flash[:notice] = 'User registration unsuccessful.'
    end
    redirect_to registration_index_path
  end

  def verification
    @user = User.find(params[:id])
    if @user.verification_token == params[:token]
      @user.update(verified: true)
    end
    render "verified"
  end

  private
  def confirm_password
    unless params[:password].empty? && params[:password] == params[:password_confirmation]
      redirect_to registration_index_path, notice: 'password didnot match'
    end
  end

  def user_params
    params.permit(:name, :email, :password)
  end
end
