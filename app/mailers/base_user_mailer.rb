class BaseUserMailer < ApplicationMailer
  default from: "abhishek #{Rails.application.credentials.dig(:development, :sender_mail)}"
  def verify(user)
    @user = user
    mail to: user.email, subject: 'verify the mail using the link'
  end

  def reset_password(user)
    @user = user
    mail to: user.email, subject: 'password reset'
  end

  def answer_notification(recipient, responder, url_slug)
    @user = recipient
    @responder = responder
    @question_url_slug = url_slug
    mail to: recipient.email, subject: 'question_answered'
  end
end
