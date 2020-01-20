class Vote < ApplicationRecord
  enum vote_type: [:upvote, :downvote, :novote]

  ###ASSOCIATIONS###
  belongs_to :voteable, polymorphic: true
  belongs_to :base_user

  ###CALLBACKS###
  after_save :change_netvotes, if: :saved_change_to_vote_type?

  ###VALIDATIONS###
  validates :base_user_id, uniqueness: { scope: :voteable}

  def change_netvotes
    voteable.update_netvotes
  end
end
