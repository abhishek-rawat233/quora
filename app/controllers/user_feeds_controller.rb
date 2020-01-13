class UserFeedsController < ApplicationController
  before_action :reset_notification_counter

  def home
    @related_users = @current_user.related_question_ids
    # @followed_user_questions = 
    @questions = @current_user.related_questions.order(updated_at: :desc)
  end

  def reset_notification_counter
    session[:notification_counter] = 0
  end
end
