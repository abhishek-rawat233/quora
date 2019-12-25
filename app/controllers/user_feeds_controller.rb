class UserFeedsController < ApplicationController
  def home
    @question = Question.new
    @questions = Question.all
    @topics = Topic.all
  end

  def submit_question
    @question = Question.new(question_params)
    @question.question_type = submission_type
    @question.base_user_id = @current_user.id
    if @question.save
      flash[:notice] = 'question saved'
      @question.save_tagged_topics(tagged_topics) if @question.question_type == 'published'
    else
      flash[:notice] = @question.errors
    end
  end

  def question_params
    params.require(:question).permit(:title, :content, pdfs:[])
  end

  def tagged_topics
    params[:question][:topics].map! { |id| id.to_i }
  end

  def submission_type
    params[:question][:commit]
  end
end
