class UserFeedsController < ApplicationController
  def home
    @questions = @current_user.questions.order(updated_at: :desc)
    @topics = Topic.all
  end
end
