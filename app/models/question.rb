class Question < ApplicationRecord
  include VoteConcern

  enum question_type: [:drafted, :published, :abusive]
  ###ASSOCIATION###
  belongs_to :author, class_name: 'BaseUser', foreign_key: :base_user_id

  has_many_attached :pdfs

  has_many :questions_topics, dependent: :destroy
  has_many :topics, through: :questions_topics
  has_many :related_users, -> { distinct }, through: :topics, source: 'users'
  has_many :notifications, dependent: :destroy

  has_many :answers, dependent: :restrict_with_error
  has_many :comments, as: :commentable, dependent: :restrict_with_error
  has_many :votes, as: :voteable, dependent: :restrict_with_error
  ###CALLBACKS###
   before_save :add_url_slug
   after_save :set_question_notifications, if: :published? && :saved_change_to_question_type?
   after_save :send_notifications, if: :published? && :saved_change_to_question_type?

  ###VALIDATION###
  validate :check_title_uniqueness
  validate :check_user_credits, if: :published?
  validates :title, :content, presence: { scope: :published }


  def check_user_credits
    unless author.credits > 0
      errors.add('user', message: I18n.t('.questions.check_user_credits.user_credit_low'))
      throw(:abort)
    end
  end

  def check_title_uniqueness
    if Question.exists?(question_type: :question_type, title: :title)
      errors.add(:title, message: I18n.t('.title_already_exists'))
      throw(:abort)
    end
  end

  def set_topics(topic_list)
    topic_list.each { |topic_id| @question.questions_topics.build( topic_id: topic_id ) }
  end

  def add_url_slug
    self.url_slug = title.parameterize
  end

  def to_param
    url_slug
  end

  def set_question_notifications
    related_user_ids.difference(base_user_id).each do |id|
      notifications.create(base_user_id: id)
    end
  end

  def send_notifications
      ActionCable.server.broadcast 'notification_channel', content: self, notified_users: related_user_ids.difference([id])
  end

  def mark_as_abusive
    update(question_type: :abusive)
  end
end
