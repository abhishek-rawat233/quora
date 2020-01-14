class Topic < ApplicationRecord
  ###ASSOCIATIONS###
  has_many :user_favorite_topics, dependent: :destroy
  has_many :users, through: :user_favorite_topics, source: :base_user
  has_many :questions_topics, dependent: :destroy
  has_many :questions, through: :questions_topics

  ###VALIDATION###
  validates :name, presence: true, uniqueness: true

  def to_param
    name
  end
end
