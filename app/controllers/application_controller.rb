class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :set_current_user

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
    user = User.find_by(api_token: cookies.signed[:api_token])
    if user.present?
      return user if user.api_token == cookies.signed[:api_token]
    end
    logout
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
    @user = User.find_by(email: user_id)
  end

  def get_user_by_email
    @user = User.find_by(email: params[:email])
  end

  def redirect_guest_users
    @current_user ||= @user
    redirect_to login_path if @current_user.nil?
  end
end
