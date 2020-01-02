class Topic < ApplicationRecord
  has_many :user_favorite_topics, dependent: :destroy
  has_many :users, through: :user_favorite_topics, source: :base_user
end
