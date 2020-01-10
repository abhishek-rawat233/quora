class NotificationsController < ApplicationController
  before_action :set_notification
  before_action :set_question

  def update
    @notification.set_status_as_seen
    @unseen_notifications -= [@notification.id]
    redirect_to user_question_path(@current_user, @question)
  end

  def set_notification
    @notification = Notification.includes(:question).find_by(id: params[:id])
    redirect_to home_path, notice: t('.no_such_notification') if @notification.nil?
  end

  def set_question
    @question = @notification.question
  end
end
