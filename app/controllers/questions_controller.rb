class QuestionsController < ApplicationController
  before_action :set_question, only: :show
  before_action :redirect_nil_question, only: :show

  def new
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
      save_tagged_topics(selected_topics) if selected_topics.present?
      redirect_to question_path, notice: t('.successfully_created')
    else
      flash[:notice] = @question.errors
    end
  end

  def submission_type
    params[:commit]
  end

  def tagged_topics
    params[:question][:topics].map! { |id| id.to_i }
  end

  def question_params
    params.require(:question).permit(:title, :content, pdfs:[])
  end

  def show
  end

  def set_question
    @question = Question.find_by(title: params[:id].gsub('-', ' '))
  end

  def redirect_nil_question
    render 'no_such_question' if @question.nil?
  end
end
