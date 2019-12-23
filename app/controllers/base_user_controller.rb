class BaseUserController < ApplicationController
  def profile
  end

  def edit_profile
  end

  def update_profile
    @current_user.image.attach(params.require(:user).permit(:profile_image)[:profile_image])
    redirect_to user_profile_path
  end
end
