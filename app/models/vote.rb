class Vote < ApplicationRecord
  enum vote_type: [:upvote, :downvote]

  ###ASSOCIATIONS###
  belongs_to :voteable, polymorphic: true
  belongs_to :base_users


end
