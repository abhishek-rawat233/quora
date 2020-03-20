require 'active_support'

class BaseUser < ApplicationRecord
  include ActiveSupport::Callbacks

  enum status: [:active, :disabled]

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
  has_many :questions, dependent: :destroy, inverse_of: :base_user
  # has_one :question_counts do
  #   questions.size
  # end
  has_many :notifications,dependent: :destroy
  has_many :report_abuses, dependent: :destroy
  has_many :comments
  has_many :answers
  has_many :answered_q, ->{distinct}, through: :answers, source: 'question'
  has_many :commented_q, ->{distinct}, through: :comments, source: 'commentable', source_type: 'Question'
   #has_many :self_ans_q, ->{ where("questions.id = ?", self.id)}, through: :answers, source: 'question'
   # has_many :se`lf_ans_q, through: :answers, source: 'question'
  has_many :self_ans_q, ->(user) { distinct.where(base_user_id: user.id) }, through: :answers, source: 'question'
  # has_many :self_unans_q, ->(user) { where.not(answers.base_user_id: user.id)}, class_name: 'Question'
  has_many :follows

  has_many :follower_relationships, foreign_key: 'following_id', class_name: 'Follow'
  has_many :followers, through: :follower_relationships, source: 'follower', dependent: :destroy

  has_many :following_relationships, foreign_key: 'base_user_id', class_name: 'Follow'
  has_many :followings, through: :following_relationships, source: 'following', dependent: :destroy

  has_many :all_questions, through: :followings, source: :questions
  ###VALIDATIONS###
  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_VALIDATOR,
                                              message: "invalid. Please enter valid mail id." }
  validates :password_digest, presence: true, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: [:create, :password_digest_changed?]


  def check_cust
    p 'running'
  end

  define_callbacks :cust_callb

  def cust_callb
    run_callbacks :cust_callb do
      p 'custom callback'
    end
  end

  set_callback :cust_callb, :after, :check_cust

#  # def self_ans_q
  #   question_ids & commented_q_ids
  # end


  def unseen_notifications
    notifications.unseen
  end

  def set_forgot_password_token
    update(forgot_password_token: generate_token("forgot_password_token"))
    BaseUserMailer.reset_password(self).deliver
  end

  def send_verification_mail
    BaseUserMailer.verify(self).deliver #unless verified?
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
