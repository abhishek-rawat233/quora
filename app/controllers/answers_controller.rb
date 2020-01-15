class AnswersController < ApplicationController
  before_action :redirect_nil_question
  before_action :set_answer, only: :create

  def new
    @answer = Answer.new
  end

  def create
    if @answer.save
      flash[:notice] = 'answer successfully created'
    else
      flash[:notice] = @answer.errors
    end
  end

  def set_answer
    options = { question_id: @question.id,
                content: params[:user_answer],
                base_user_id: @current_user.id}
    @answer = Answer.new(options)
  end

  def redirect_nil_question
    @question = Question.find_by(url_slug: params[:question])
    redirect_to user_question_path(@current_user, params[:question]) if @question.nil?
  end
end
