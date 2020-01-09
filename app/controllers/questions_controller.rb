class QuestionsController < ApplicationController
  before_action :set_question_instance, only: :create
  before_action :set_question, only: :show
  before_action :redirect_nil_question, only: :show

  def new
    @question = Question.new
    @topics = Topic.all
  end

  def create
    @question = Question.new(question_params)
    @question.question_type = submission_type
    @question.base_user_id = @current_user.id
    if @question.save
      flash[:notice] = 'question asked'
      save_topics
      save_notifications
      redirect_to question_path(@question.url_slug), notice: t('.successfully_created')
    else
      flash[:notice] = @question.errors
    end
  end

  def set_question_instance
    @question = Question.new(question_params)
    @question.question_type = submission_type
    @question.base_user_id = @current_user.id
  end

  def save_topics
    selected_topics = tagged_topics
    @question.save_tagged_topics(selected_topics) if selected_topics.present?
  end

  def index
    @questions = @current_user.questions.published.order(updated_at: :desc)
  end

  def update
    #to be filled...
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
    @question = Question.find_by(url_slug: params[:id])
  end

  def redirect_nil_question
    redirect_to home_path, notice: 'no_such_question' if @question.nil?
  end

  def save_notifications
    @question.related_users.ids.each do |id|
      @question.notifications.create(base_user_id: id)
    end
  end
end
