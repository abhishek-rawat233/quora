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

  has_many :answers, dependent: :restrict_with_exception
  has_many :comments, as: :commentable, dependent: :restrict_with_exception
  has_many :votes, as: :voteable, dependent: :restrict_with_exception
  ###CALLBACKS###
   # before_save :check_title_uniqueness
   before_save :add_url_slug
   # after_create :set_question_notifications
   # after_create :send_notifications


    before_validation :a
    after_validation :ab
    before_save :ac
    around_save :ad
    before_create :ar
    around_create :ae
    after_create :af
    before_update :ag
    around_update :ah
    after_update :ai
    after_save :aj
    after_commit :aq
    before_destroy :am
    around_destroy :an
    after_destroy :ao
    after_rollback :ap

    ###VALIDATION###
    validate :check_user_credits, if: :published?
    validates :title, :content, presence: { scope: :published }

    def a
      p 'before_validation'
    end
    def ab
      p 'after_validation'
    end
    def ac
      p 'before_save'
    end
    def ad
      p 'around_save'
    end
    def aj
      p 'after_save'
    end
    def ar
      p 'before_create'
    end
    def ae
      p 'around_create'
    end
    def af
      p 'after_create'
    end
    def ag
      p 'before_update'
    end
    def ah
      p 'around_update'
    end
    def ai
      p 'after_update'
    end
    def aj
      p 'after_save'
    end
    def aq
      p 'after_commit'
    end
    def am
      p 'before_destroy'
    end
    def an
      p 'around_destroy'
    end
    def ao
      p 'after_destroy'
    end
    def ap
      p 'after_rollback'
    end


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
    related_user_ids.deifference(base_user_id).each do |id|
      notifications.create(base_user_id: id)
    end
  end

  def send_notifications
    if published?
      ActionCable.server.broadcast 'notification_channel', content: self, notified_users: related_user_ids.difference([id])
    end
  end

  def mark_as_abusive
    update(question_type: :abusive)
  end
end
