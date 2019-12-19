module UserConcern
  def set_remember_login_token(user)
    user.update(remember_login_token: SecureRandom.urlsafe_base64)
  end

  def forgot_password
    user = User.find_by(email: params[:email])
    user.set_forgot_password_token
    user.save
    UserMailer.reset_password(user).deliver
  end

  def destroy_password_token
    user = User.find_by(id: params[:user_id])
    user.remove_password_token
    user.save
  end

  def set_credits
    @user.update(credits: 5) unless @user.changes.empty?
  end
end
