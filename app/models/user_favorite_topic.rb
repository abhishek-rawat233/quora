class UserFavoriteTopic < ApplicationRecord
  belongs_to :base_user
  belongs_to :topic

  validates :base_user_id, uniqueness: {scope: :topic_id}
end
