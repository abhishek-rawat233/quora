class Question < ApplicationRecord
  belongs_to :user
  enum question_type: [:drafts, :published]
  has_many_attached :pdfs
  validates :title, uniqueness: true
end
