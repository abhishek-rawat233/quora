class UsersController < ApplicationController
  def update_profile
    @current_user.add_image(get_profile_image) if params.keys.include?("user")
    redirect_to user_profile_path, notice: 'upload successful'
  end

  def get_profile_image
    params.require(:user).permit(:profile_image)[:profile_image]
  end
end
