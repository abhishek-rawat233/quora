class Vote < ApplicationRecord
  enum vote_type: [:upvote, :downvote, :novote]

  ###ASSOCIATIONS###
  belongs_to :voteable, polymorphic: true
  belongs_to :base_user

  ###CALLBACKS###
  around_update :set_votes
  after_save :change_netvotes 

  ###VALIDATIONS###
  validates :base_user_id, uniqueness: { scope: :voteable}

  def set_votes
    unless vote_type_changed?
      self.vote_type = 'novote'
    end
    yield
  end

  def change_netvotes
    voteable.update_netvotes
  end
end
