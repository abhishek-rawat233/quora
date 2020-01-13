class FollowsController < ApplicationController
  before_action :find_following, only: :destroy

  def update
    @follow = Follow.new
    @follow.update(base_user_id: params[:user_id], following_id: params[:id])
    redirect_to user_profile_path(params[:id])
  end

  def destroy
    @follow.destroy
    redirect_to user_profile_path(params[:id])
  end

  def find_following
    @follow = Follow.find_by(base_user_id: params[:user_id], following_id: params[:id])
  end
end
