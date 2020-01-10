class UserFeedsController < ApplicationController
  def home
    @questions = @current_user.related_questions.order(updated_at: :desc)
  end
end
