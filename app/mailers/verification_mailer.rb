class VerificationMailer < ApplicationMailer
  default from: 'abhishek <abhishek.rawat@vinsol.com>'
  def verify(user, base_url)
    @user = user
    @base_url = base_url
    mail to: user.email, subject: 'verify the mail using the link'
  end
end
