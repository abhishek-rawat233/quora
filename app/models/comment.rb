class Comment < ApplicationRecord
  include VoteConcern

  ###VALIDATIONS###
  validates :content, presence: true

  ###ASSOCIATIONS###
  has_many :votes, as: :voteable, dependent: :destroy
  belongs_to :commentable, polymorphic: true

  ###CALLBACKS###
  # before_save :update_netvotes

end
