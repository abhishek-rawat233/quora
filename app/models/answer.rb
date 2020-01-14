class Answer < ApplicationRecord
  include VoteConcern

  ###CALLBACKS###
  before_save :update_credits
  after_create :send_notification_mail
  # after_update :revert_abusive_answer_credits

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
