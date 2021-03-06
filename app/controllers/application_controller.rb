class ApplicationController < ActionController::Base
  before_action :set_current_user
  before_action :redirect_guest_users
  before_action :set_locale

  def set_locale
    if params[:locale]
      if I18n.available_locales.map(&:to_s).include?(params[:locale])
        I18n.locale = params[:locale]
      else
        flash.now[:notice] = "#{params[:locale]} translation not available"
        logger.error flash.now[:notice]
        I18n.locale = I18n.default_locale
      end
    end
  end

  def set_current_user
    @current_user ||= User.find_by(api_token: session[:api_token]) || get_api_stored_user
  end

  def get_api_stored_user
    user ||= User.find_by(api_token: cookies.signed[:api_token])
    user if user.present? && user.api_token == cookies.signed[:api_token]
  end

  def logout
    clear_cookies
    session[:api_token] = nil
    redirect_to login_path, notice: t('.logout')
  end

  def clear_cookies
    if cookies.signed[:api_token]
      cookies.signed[:api_token] = nil
    end
  end

  def get_user_by_id
    user_id = params[:user_id] || params[:id]
    @user = User.find_by(id: user_id)
  end

  def get_user_by_email
    @user = User.find_by(email: params[:email])
  end

  def redirect_invalid_user
    redirect_to signup_path, notice: t('.contact_help') if @user.nil?
  end

  def redirect_guest_users
    logout if @current_user.nil?
  end

  def check_user_validity
    redirect_to login_url, notice: t('.authentication_failure') unless @user.present? && @user.validate_password(params[:password])
  end
end
