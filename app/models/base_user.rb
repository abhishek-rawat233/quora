class BaseUser < ApplicationRecord
  include TokenableConcern
  has_secure_password

  ###CALLBACKS###
  before_create :set_api_token
  after_create_commit :set_verification_token
  after_create_commit :send_verification_mail
  after_commit :set_credits, if: [:verified_changed?, :verified?]


  ####association####
  has_one_attached :image
  has_many :user_favorite_topics, dependent: :destroy
  has_many :topics, through: :user_favorite_topics


  ###VALIDATIONS###
  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_VALIDATOR,
                                              message: "invalid. Please enter valid mail id." }
  validates :password_digest, presence: true, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: [:create, :password_digest_changed?]

  def set_forgot_password_token
    update(forgot_password_token: generate_token("forgot_password_token"))
    BaseUserMailer.reset_password(user).deliver
  end

  def send_verification_mail
    BaseUserMailer.verify(self).deliver_later
  end

  def set_api_token
    new_api_token = generate_token("api_token")
    self.api_token = new_api_token
  end

  def update_password(new_password)
    update(password_digest: new_password, forgot_password_token: nil)
  end

  def validate_password(password)
    try(:authenticate, password)
  end

  def add_image(profile_image)
    self.image.attach(profile_image)
  end

  def verify
    update(verified: true)
  end

  def set_credits
    credits = 5
  end

  private
  def set_verification_token
    self.verification_token = generate_token("verification_token")
  end
end
