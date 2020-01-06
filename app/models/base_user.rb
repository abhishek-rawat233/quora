class BaseUser < ApplicationRecord
  include TokenableConcern
  has_secure_password

  ###CALLBACKS###
  before_create :set_api_token
  after_create_commit :set_verification_token
  # after_
  # after_update :set_credits, if: [:verified_changed?, :verified?]


  ####association####
  has_one_attached :image
  has_many :user_favorite_topics, dependent: :destroy
  has_many :topics, through: :user_favorite_topics
  has_many :related_questions, -> { distinct }, through: :topics, source: 'questions'
  has_many :questions
  has_many :notifications,dependent: :destroy

  ###VALIDATIONS###
  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_VALIDATOR,
                                              message: "invalid. Please enter valid mail id." }
  validates :password_digest, presence: true, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: [:create, :password_digest_changed?]

  def unseen_notifications
    notifications.where(status: :unseen)
  end

  def set_forgot_password_token
    update(forgot_password_token: generate_token("forgot_password_token"))
    BaseUserMailer.reset_password(self).deliver
  end

    def send_verification_mail
    BaseUserMailer.verify(self).deliver_later
  end

  def set_api_token
    new_api_token = generate_token("api_token")
    self.api_token = new_api_token
  end

  def update_password(new_password)
    update(password: new_password, forgot_password_token: nil)
  end

  def validate_password(password)
    try(:authenticate, password)
  end

  def add_image(profile_image)
    self.image.attach(profile_image)
  end

  def verify
    self.verified = true
    set_credits
    save
  end

  def set_credits
    self.credits = 5 if verified? && verified_changed?
  end

  def add_topics(topic_ids)
    topic_ids.difference(self.topics.ids).
    each { |topic_id| user_favorite_topics.create({ topic_id: topic_id }) }
  end

  private
  def set_verification_token
    update(verification_token: generate_token("verification_token"))
    send_verification_mail
  end
end
