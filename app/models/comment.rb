class Comment < ApplicationRecord
  # include VoteConcern

  ###VALIDATIONS###
  validates :content, presence: true

  ###ASSOCIATIONS###
  belongs_to :commentable, polymorphic: true

  ###CALLBACKS###
  # before_save :update_netvotes

end
