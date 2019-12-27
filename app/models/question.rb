class Question < ApplicationRecord
  ###ASSOCIATION###
  belongs_to :base_user
  enum question_type: [:drafts, :published]

  has_many_attached :pdfs
  has_many :user_favorite_topics

  has_many :questions_topics
  has_many :topics, through: :questions_topics

  ###CALLBACKS###
  # before_save :save_tagged_topics

  ###VALIDATION###
  validates :title, uniqueness: true
  validates :title, :content, presence: true, if: -> { question_type == 'published' }

  def save_tagged_topics(topic_ids)
    topic_ids.each { |topic_id| questions_topics.create ({topic_id: topic_id}) }
  end

  def to_param
    title
  end
end
