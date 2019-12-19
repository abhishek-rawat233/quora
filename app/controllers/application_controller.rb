class ApplicationController < ActionController::Base
  before_action :set_current_user

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
