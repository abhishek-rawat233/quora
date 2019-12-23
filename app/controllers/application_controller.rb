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
    @current_user = User.find_by(id: session[:user_id]) || get_api_stored_user
  end

  def get_api_stored_user
    user = User.find_by(api_token: cookies.signed[:api_token])
    if user.present?
      if user.api_token == cookies.signed[:api_token]
        user
      else
        logout
      end
    end
  end

  def logout
    clear_stored_user_api
    session[:user_id] = nil
    redirect_to login_path, notice: t('.logout', notice: 'Please login again.')
  end

  def clear_stored_user_api
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
    redirect_to login_path if @current_user.nil?
  end
end
