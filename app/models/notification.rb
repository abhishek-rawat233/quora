class Notification < ApplicationRecord
  enum status: [:unseen, :seen]

  belongs_to :base_user
  belongs_to :question, inverse_of: :notifications

  def set_status_as_seen
    update(status: :seen)
  end
end
