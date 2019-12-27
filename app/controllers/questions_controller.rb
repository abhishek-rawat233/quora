class QuestionsController < ApplicationController
  def show
    @question = Question.find_by(id: params[:title])
  end
end
