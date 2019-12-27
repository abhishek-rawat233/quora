class UserFeedsController < ApplicationController
  def home
    @questions = @current_user.questions.order(updated_at: :desc)
    @topics = Topic.all
  end

  def ask_question
    @question = Question.new
    @topics = Topic.all
  end

  def submit_question
    @question = Question.new(question_params)
    @question.question_type = submission_type
    @question.base_user_id = @current_user.id
    if @question.save
      flash[:notice] = 'question asked'
      selected_topics = tagged_topics
      save_question_topics(selected_topics) if selected_topics.present?
      redirect_to home_path
    else
      flash[:notice] = @question.errors
    end
  end

  def save_question_topics
    @question.save_tagged_topics(tagged_topics) if @question.question_type == 'published'
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
