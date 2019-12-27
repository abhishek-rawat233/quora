class Question < ApplicationRecord
  enum question_type: [:drafts, :published]
  ###ASSOCIATION###
  belongs_to :base_user

  has_many_attached :pdfs
  has_many :user_favorite_topics

  has_many :questions_topics
  has_many :topics, through: :questions_topics

  ###CALLBACKS###
   before_save :check_title_uniqueness

  ###VALIDATION###
  validates :title, :content, presence: true, if: -> { question_type == 'published' }

  def save_tagged_topics(topic_ids)
    topic_ids.each { |topic_id| questions_topics.create ({topic_id: topic_id}) }
  end

  def check_title_uniqueness
    if Question.where(title: title).ids.difference(id).empty?
      errors.add(:title, t('.title_already_exists'))
      throw(:abort)
    end
  end

  def to_param
    title.gsub(' ', '-')
  end
end
