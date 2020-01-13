class Question < ApplicationRecord
  enum question_type: [:drafted, :published]
  ###ASSOCIATION###
  belongs_to :author, class_name: 'BaseUser', foreign_key: :base_user_id

  has_many_attached :pdfs

  has_many :questions_topics, dependent: :destroy
  has_many :topics, through: :questions_topics
  has_many :related_users, -> { distinct }, through: :topics, source: 'users'
  has_many :notifications, dependent: :destroy

  ###CALLBACKS###
   before_save :check_title_uniqueness
   before_save :add_url_slug
   after_create :set_question_notifications
   after_create :send_notifications

  ###VALIDATION###
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
    self.url_slug = self.title.parameterize
  end

  def to_param
    url_slug
  end

  def set_question_notifications
    related_user_ids.deifference(base_user_id).each do |id|
      notifications.create(base_user_id: id)
    end
  end

  def send_notifications
    if published?
      ActionCable.server.broadcast 'notification_channel', content: self, notified_users: related_user_ids.difference([id])
    end
  end
end
