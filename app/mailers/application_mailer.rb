class ApplicationMailer < ActionMailer::Base
  default from: "#{Rails.application.credentials.dig(:development, :sender_mail)}"
  layout 'mailer'
end
