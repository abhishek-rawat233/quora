class Question < ApplicationRecord
  include VoteConcern

  enum question_type: [:drafts, :published]
  ###ASSOCIATION###
  belongs_to :base_user

  has_many_attached :pdfs
  has_many :user_favorite_topics

  has_many :questions_topics, dependent: :destroy
  has_many :topics, through: :questions_topics
  has_many :related_users, -> { distinct }, through: :topics, source: 'users'
  has_many :notifications,dependent: :destroy

  has_many :answers, dependent: :restrict_with_exception
  has_many :comments, as: :commentable, dependent: :restrict_with_exception
  has_many :votes, as: :voteable, dependent: :restrict_with_exception
  ###CALLBACKS###
   before_save :check_title_uniqueness
   before_save :add_url_slug
   before_save :update_netvotes

  ###VALIDATION###
  validate :check_user_credits
  validates :title, :content, presence: true, if: -> { question_type == 'published' }

  def save_tagged_topics(topic_ids)
    topic_ids.each { |topic_id| questions_topics.create ({topic_id: topic_id}) }
  end

  def check_user_credits
    unless base_user.credits > 0
      errors.add('user', message: I18n.t('.questions.check_user_credits.user_credit_low'))
      throw(:abort)
    end
  end

  def check_title_uniqueness
    if Question.where(question_type: :question_type, title: title).ids.difference([id]).present?
      errors.add(:title, message: I18n.t('.title_already_exists'))
      throw(:abort)
    end
  end

  def add_url_slug
    self.url_slug = title.parameterize
  end

  def to_param
    url_slug
  end
end
