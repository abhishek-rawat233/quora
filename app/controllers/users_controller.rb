class UsersController < ApplicationController
  def edit_question
    
  end

  def delete_question
  end

  def questions
    @questions = @current_user.questions.where(question_type: :published).order(updated_at: :desc)
  end

  def update_profile
    @current_user.add_image(get_profile_image) if params.keys.include?("user")
    selected_topics = get_favorite_topics
    @current_user.add_topics(selected_topics) if selected_topics.present?
    redirect_to user_profile_path, notice: 'upload successful'
  end

  def edit_profile
    @topics = Topic.all
  end

  def get_profile_image
    params.require(:user).permit(:profile_image)[:profile_image]
  end

  def get_favorite_topics
    params[:user][:topic_id].map! { |topic_id| topic_id.to_i }
  end
end
