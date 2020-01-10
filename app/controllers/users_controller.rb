class UsersController < ApplicationController
  #update profile
  def update
    debugger
    if params.keys.include?("user")
      @current_user.add_image(get_profile_image) unless params[:user][:profile_image].nil?
      selected_topics = get_favorite_topics
      @current_user.add_topics(selected_topics)
    end
    redirect_to user_path, notice: t('.successfully_uploaded')
  end

  #edit profile
  def edit
    @topics = Topic.all
  end

  def get_profile_image
    params.require(:user).permit(:profile_image)[:profile_image]
  end

  def get_favorite_topics
    params[:user][:topic_id].map!(&:to_i)
  end

  def mark_all_as_seen
    @unseen_notifications.map(&:set_status_as_seen)
    @unseen_notifications = Notification.none
  end
end
