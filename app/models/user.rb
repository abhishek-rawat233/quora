class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, format: { with: EMAIL_VALIDATOR,
                                              message: "invalid. Please enter valid mail id." }
  validates :email, uniqueness: true
end
