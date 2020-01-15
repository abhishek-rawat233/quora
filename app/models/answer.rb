class Answer < ApplicationRecord
  include VoteConcern

  ###CALLBACKS###
  # before_save :update_credits
  # after_create :send_notification_mail
  # after_update :revert_abusive_answer_credits

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

  def a
    p 'before_validation2'
  end
  def ab
    p 'after_validation2'
  end
  def ac
    p 'before_save2'
  end
  def ad
    p 'around_save2'
  end
  def aj
    p 'after_save2'
  end
  def ar
    p 'before_create2'
  end
  def ae
    p 'around_create2'
  end
  def af
    p 'after_create2'
  end
  def ag
    p 'before_update2'
  end
  def ah
    p 'around_update2'
  end
  def ai
    p 'after_update2'
  end
  def aj
    p 'after_save2'
  end
  def aq
    p 'after_commit2'
  end
  def am
    p 'before_destroy2'
  end
  def an
    p 'around_destroy2'
  end
  def ao
    p 'after_destroy2'
  end
  def ap
    p 'after_rollback2'
  end

  ###ASSOCIATION###
  belongs_to :question
  belongs_to :base_user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votes, as: :voteable, dependent: :destroy

  ###VALIDATIONS###
  validates :content, presence: true

  def update_credits
    unless abusive?
      if netvotes < UPVOTE_CHECK_COUNT && point_credited
        base_user.decrement_credits
        update(point_credited: false)
      elsif netvotes > UPVOTE_CHECK_COUNT && !point_credited
        base_user.increment_credits
        update(point_credited: true)
      end
    end
  end

  def send_notification_mail
    question.base_user.send_answer_notification_mail(self.base_user, question.url_slug)
  end

  def mark_as_abusive
    super
    if point_credited
      base_user.decrement_credits
    end
  end

  def unmark_as_abusive
    update(abusive: false)
    base_user.increment_credits
  end
end
