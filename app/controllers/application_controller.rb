class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :set_current_user

  def set_locale
    if params[:locale]
      if I18n.available_locales.map(&:to_s).include?(params[:locale])
        I18n.locale = params[:locale]
      else
        flash.now[:notice] =
          "#{params[:locale]} translation not available"
        logger.error flash.now[:notice]
        I18n.locale = I18n.default_locale
      end
    end
  end

  def set_current_user
    session[:user_id] ||= remember_user
    user_id = session[:user_id]
    @current_user ||= User.find_by(id: user_id)
  end

  def remember_user
    user = User.find_by(id: cookies.signed[:user_id])
    if user
      if user.remember_login_token == cookies.signed[:remember_login_token]
        user_id = cookies.signed[:user_id]
      end
    end
  end
end
