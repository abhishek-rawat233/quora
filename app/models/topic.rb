class Topic < ApplicationRecord
  has_many :user_favorite_topics, dependent: :destroy
  has_many :users, through: :user_favorite_topics, source: :base_user
  has_many :questions_topics
  has_many :questions, through: :questions_topics

  validates :name, presence: true
end
