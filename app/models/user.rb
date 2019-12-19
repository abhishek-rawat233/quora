class User < ApplicationRecord
  before_save :set_verification_token
  has_secure_password
  validates :email, presence: true, format: { with: EMAIL_VALIDATOR,
                                              message: "invalid. Please enter valid mail id." }
  validates :email, uniqueness: true

  def set_forgot_password_token
    self.forgot_password_token = SecureRandom.urlsafe_base64
  end

  def remove_password_token
    self.forgot_password_token = nil
  end

  private
  def set_verification_token
    self.verification_token = SecureRandom.urlsafe_base64
  end

end
