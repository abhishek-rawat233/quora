class QuestionsTopic < ApplicationRecord
  belongs_to :question
  belongs_to :topic
end
