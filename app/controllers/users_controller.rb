class UsersController < ApplicationController
  def edit_question

  end

  def delete_question
  end

  def update#update profile
    @current_user.add_image(get_profile_image) if params.keys.include?("user")
    selected_topics = get_favorite_topics
    @current_user.add_topics(selected_topics) if selected_topics.present?
    redirect_to user_path, notice: t('.successfully_uploaded')
  end

  def edit#edit profile
    @topics = Topic.all
  end

  def get_profile_image
    params.require(:user).permit(:profile_image)[:profile_image]
  end

  def get_favorite_topics
    params[:user][:topic_id].map! { |topic_id| topic_id.to_i }
  end

  def mark_all_as_seen
    @unseen_notifications.each { |notification| notification.set_status_as_seen }
    @unseen_notifications = Notification.none
  end
end
