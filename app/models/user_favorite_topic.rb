class UserFavoriteTopic < ApplicationRecord
  belongs_to :base_user
  belongs_to :topic
end
