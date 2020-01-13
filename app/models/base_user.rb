class BaseUser < ApplicationRecord
  include TokenableConcern
  has_secure_password

  ###CALLBACKS###
  before_create :set_api_token
  before_save :set_credits, if: [:verified_changed?, :verified?]
  after_create :set_verification_token
  after_create :send_verification_mail



  ####association####
  has_one_attached :image
  has_many :user_favorite_topics, dependent: :destroy
  has_many :topics, through: :user_favorite_topics
  has_many :related_questions, -> { distinct }, through: :topics, source: 'questions'
  has_many :questions, dependent: :destroy
  has_many :notifications, dependent: :destroy

  ###VALIDATIONS###
  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_VALIDATOR,
                                              message: "invalid. Please enter valid mail id." }
  validates :password_digest, presence: true, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: [:create, :password_digest_changed?]

  def unseen_notifications
    notifications.unseen
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
    image.attach(profile_image)
  end

  def verify
    self.verified = true
    save
  end

  def set_credits
    self.credits = DEFAULT_CREDITS
  end

  def add_topics(new_topic_ids)
    old_topic_ids = user_favorite_topic_ids
    common_topic_ids = old_topic_ids & new_topic_ids
    UserFavoriteTopic.where(id: old_topic_ids - common_topic_ids).destroy_all
    new_topic_ids.difference(common_topic_ids).each do |topic_id|
      user_favorite_topics.create({ topic_id: topic_id })
    end
  end

  def get_profile_image
    if image.attached?
      image
    else
      "default_profile_image.png"
    end
  end

  def increment_credits
    update(credits: credits + 1)
  end

  def decrement_credits
    update(credits: credits - 1)
  end

  def send_answer_notification_mail(sender, question_slug)
    BaseUserMailer.answer_notification(self, sender, question_slug).deliver_later
  end

  private
  def set_verification_token
    update(verification_token: generate_token("verification_token"))
  end
end
