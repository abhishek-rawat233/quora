class BaseUser < ApplicationRecord
  after_create_commit :send_verification_mail unless :verified

  before_save :set_verification_token
  before_create :set_api_token
  has_secure_password
  has_one_attached :image
  has_many :user_favorite_topics
  has_many :topics, through: :user_favorite_topics
  has_many :questions, -> { distinct }, through: :topics

  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_VALIDATOR,
                                              message: "invalid. Please enter valid mail id." }
  validates :password_digest, presence: true, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: [:create, :password_digest_changed?]

  def set_forgot_password_token
    update(forgot_password_token: generate_token)
    BaseUserMailer.reset_password(user).deliver
  end

  def send_verification_mail
    BaseUserMailer.verify(self).deliver_later
  end

  def set_api_token
    new_api_token = generate_token
    while User.find_by(api_token: new_api_token).present?
      new_api_token = generate_token
    end
    update(api_token: new_api_token)
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
    update(verified: true, credits: 5)
  end

  def add_topics(topic_ids)
    topic_ids.difference(self.topics.ids).
      each { |topic_id| user_favorite_topics.create({ topic_id: topic_id }) }
  end

  private
  def generate_token
    SecureRandom.urlsafe_base64
  end

  def set_verification_token
    self.verification_token = generate_token
  end
end
