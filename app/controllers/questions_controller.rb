class QuestionsController < ApplicationController
  before_action :set_question_instance, only: :create
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def new
    @question = Question.new
    @topics = Topic.all
  end

  def create
    if @question.save
      redirect_to user_question_path(@current_user, @question.url_slug), notice: t('.successfully_created')
    else
      flash[:notice] = @question.errors.full_messages
    end
  end

  def set_question_instance
    @question = Question.new(question_params.merge(question_type: params[:commit], base_user_id: @current_user.id))
    @question.set_topics(tagged_topics)
  end

  def index
    user = BaseUser.includes(:questions).find_by(id: @current_user.id)
    @questions = user.questions.order(updated_at: :desc)
  end

  def edit
    @topics = Topic.all
  end

  def update
    if @question.update(question_params)
      redirect_to user_home_path, notice: 'question successfully edited'
    else
      flash['notice'] = @question.errors.full_messages
    end
  end

  def destroy
    if @question.destroy
      redirect_to user_questions_path(@current_user), notice: 'Product was successfully destroyed'
    else
      redirect_to user_questions_path(@current_user), notice: @question.errors.full_messages
    end
  end


  def tagged_topics
    params[:question][:topics].map!(&:to_i)
  end

  def question_params
    params.require(:question).permit(:title, :content, pdfs:[])
  end

  def show
  end

  def set_question
    @question = Question.find_by(url_slug: params[:id])
    redirect_nil_question
  end

  def redirect_nil_question
    redirect_to user_home_path, notice: 'no_such_question' if @question.nil?
  end
end
