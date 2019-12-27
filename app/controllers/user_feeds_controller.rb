class UserFeedsController < ApplicationController
  def home
    @questions = @current_user.questions.order(updated_at: :desc)
    @topics = Topic.all
  end
  # def save_question_topics
  #   @question.save_tagged_topics(tagged_topics) if @question.question_type == 'published'
  # end

end
