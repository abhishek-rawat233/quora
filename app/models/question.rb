class Question < ApplicationRecord
  belongs_to :base_user
  enum question_type: [:drafts, :published]

  has_many_attached :pdfs
  has_many :user_favorite_topics

  has_many :questions_topics
  has_many :topics, through: :questions_topics

  validates :title, uniqueness: true
  validates :title, :content, presence: true, if: -> { question_type == 'published' }

  def save_tagged_topics(topics)
    topics.each { |topic| questions_topics.create ({topics_id: topic}) }
  end
end
