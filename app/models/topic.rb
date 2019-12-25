class Topic < ApplicationRecord
  has_many :user_favorite_topics
  has_many :base_users, through: :user_favorite_topics
  has_many :questions_topics
  has_many :questions, through: :questions_topics

  validates :name, presence: true
end
