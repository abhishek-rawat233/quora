class Answer < ApplicationRecord
  include VoteConcern
  ###CALLBACKS###
  before_save :update_credits
  after_create :send_notification_mail

  ###ASSOCIATION###
  belongs_to :question
  belongs_to :base_user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votes, as: :voteable, dependent: :destroy

  ###VALIDATIONS###
  validates :content, presence: true

  def update_credits
    if netvotes < UPVOTE_CHECK_COUNT && is_point_credited
      base_user.decrement_credits
      update(is_point_credited: false)
    elsif netvotes > UPVOTE_CHECK_COUNT && !is_point_credited
      base_user.increment_credits
      update(is_point_credited: true)
    end
  end

  def send_notification_mail
    question.base_user.send_answer_notification_mail(self.base_user, question.url_slug)
  end
end
