class UserMailer < ApplicationMailer
  default from: 'abhishek <abhishek.rawat@vinsol.com>'
  def verify(user)
    @user = user
    mail to: user.email, subject: 'verify the mail using the link'
  end

  def reset_password(user)
    @user = user
    mail to: user.email, subject: 'password reset'
  end
end
