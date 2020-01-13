class Follow < ApplicationRecord
  belongs_to :follower, foreign_key: 'base_user_id', class_name: "BaseUser"
  belongs_to :following, foreign_key: 'following_id', class_name: "BaseUser"

  ###VALIDATION###
  validates :base_user_id, uniqueness: { scope: :following_id }

end
