class Answer < ApplicationRecord
  include VoteConcern
  ###CALLBACKS###
  before_save :update_netvotes
  ###ASSOCIATION###
  belongs_to :question
  has_many :comments, as: :commentable
  has_many :votes, as: :voteable
  # has_many :votes

  ###VALIDATIONS###
  validates :content, presence: true
end
