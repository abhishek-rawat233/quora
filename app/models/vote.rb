class Vote < ApplicationRecord
  enum vote_type: [:upvote, :downvote]

  ###ASSOCIATIONS###
  belongs_to :voteable, polymorphic: true
  belongs_to :base_users

  ###CALLBACKS###
  after_save :change_netvotes

  ###VALIDATIONS###
  validates :base_user_id, uniqueness: { scope: :voteable}

  def change_netvotes
    voteable.update_netvotes
  end
end
