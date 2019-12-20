class User < ApplicationRecord
  after_create_commit :send_verification_mail

  before_save :set_verification_token
  has_secure_password
  has_one_attached :image
  has_many :interests
  has_many :topics, through: :interests

  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_VALIDATOR,
                                              message: "invalid. Please enter valid mail id." }
  validates :password_digest, presence: true, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: [:create, :password_digest_changed?]

  def set_forgot_password_token
    self.forgot_password_token = SecureRandom.urlsafe_base64
  end

  def remove_password_token
    self.forgot_password_token = nil
  end

  def send_verification_mail
    UserMailer.verify(self).deliver_later
  end

  private
  def set_verification_token
    self.verification_token = SecureRandom.urlsafe_base64
  end

end
