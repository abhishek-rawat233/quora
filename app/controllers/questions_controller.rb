class QuestionsController < ApplicationController
  before_action :set_question_instance, only: :create
  before_action :set_question, only: :show
  before_action :redirect_nil_question, only: :show
  before_action :update_notification, only: :show

  def new
    @question = Question.new
    @topics = Topic.all
  end

  def create
    if @question.save
      flash[:notice] = 'question asked'
      selected_topics = tagged_topics
      @question.save_tagged_topics(selected_topics) if selected_topics.present?
      set_question_notifications if @question.question_type == 'published'
      redirect_to user_question_path(@current_user, @question.url_slug), notice: t('.successfully_created')
    else
      flash[:notice] = @question.errors
    end
  end

  def set_question_notifications
    save_notifications
    ActionCable.server.broadcast 'notification_channel', content: @question, notified_users: get_recipients
  end

  def get_recipients
    @question.related_user_ids.difference([@current_user.id])
  end

  def set_question_instance
    @question = Question.new(question_params)
    @question.question_type = submission_type
    @question.base_user_id = @current_user.id
  end

  def index
    @questions = @current_user.questions.where(question_type: :published).order(updated_at: :desc)
  end

  def update
    #to be filled...
  end

  def delete
    #to be done
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
    @answers = @question.answers.order(netvotes: :desc)
  end

  def set_question
    @question = Question.find_by(url_slug: params[:id])
  end

  def redirect_nil_question
    render 'no_such_question' if @question.nil?
  end

  def save_notifications
    @question.related_users.ids.each do |id|
      @question.notifications.create(base_user_id: id)
    end
  end

  def update_notification
    notification = @question.notifications.find_by(base_user_id: @current_user.id)
    notification.set_status_as_seen
    @unseen_notifications -= [notification]
  end
end
