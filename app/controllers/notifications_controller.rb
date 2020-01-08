class NotificationsController < ApplicationController
  before_action :set_notification, only: :update
  before_action :set_question, only: :update

  def update
    notification_id = @notification.id
    @notification.set_status_as_seen
    @unseen_notifications -= [notification_id]
    redirect_to user_question_path(@current_user, @question)
  end

  def set_notification
    @notification = Notification.find_by(id: params[:id])
  end

  def set_question
    @question = @notification.question
  end
end
