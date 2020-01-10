class CommentsController < ApplicationController
  before_action :set_question, only: :create_comment
  before_action :set_params, only: :create_comment

  def new
    @comment = Comment.new
  end

  def create_comment
    @comment = Comment.new(comment_params)
    # debugger
    if @comment.save
      flash[:notice] = 'comment successfully created'
    else
      flash[:notice] = @comment.errors.full_messages
    end
    redirect_to user_question_path(@current_user, @question)
  end

  def comment_params
    params.permit(:content, :commentable_type, :commentable_id, :base_user_id)
  end

  def set_question
    @question = Question.find_by(url_slug: params[:question])
  end

  def set_params
    params[:commentable_id] = @question.id if params[:commentable_type] == 'Question'
    params[:base_user_id] = @current_user.id
  end
end
