class Topic < ApplicationRecord
  has_many :user_favorite_topics, dependent: :destroy
  has_many :base_users, through: :user_favorite_topics
end
