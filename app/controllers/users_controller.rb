class UsersController < ApplicationController

  #update profile
  def update
    if params.keys.include?("user")
      @current_user.add_image(get_profile_image) unless params[:user][:profile_image].nil?
      @current_user.add_topics(get_favorite_topic_ids)
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

  def get_favorite_topic_ids
    params[:user][:topic_id].map!(&:to_i)
  end

  def mark_all_as_seen
    @unseen_notifications.map(&:set_status_as_seen)
    @unseen_notifications = Notification.none
  end

  def show_profile
    @user = User.find_by(id: params[:user_id])
  end

  def home
    @questions = Question.all.order(updated_at: :desc)
    @user_following_ids = @current_user.following_ids
    @related_question_ids = @current_user.related_question_ids
  end

  def index
    @user = BaseUser.eager_load(:questions).find_by(id: @current_user.id)
    render json: @user, only: [:id, :name], include: {
      questions: {
        only: [:content],
        include: {
          comments: {
            only: [:content]
          },
         answers: {
           only: [:content],
           include: {
             comments: {
               only: [:content]
             }
           }
         }
        }
      }
    }
  end
end
