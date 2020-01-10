class Answer < ApplicationRecord
  include VoteConcern
  ###CALLBACKS###
  # before_save :update_netvotes
  before_save :update_credits
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
end
