class AnswersController < ApplicationController
  before_action :set_answer, only: :create

  def new
    @answer = Answer.new
  end

  def create
    @answer = Answer.new(set_answer)
    if @answer.save
      flash[:notice] = 'answer successfully created'
    else
      flash[:notice] = @answer.errors
    end
    redirect_to user_question_path(@current_user, params[:question])
  end

  def set_answer
    { question_id: Question.find_by(url_slug: params[:question]).id,
      content: params[:user_answer],
      base_user_id: @current_user.id}
  end
end
