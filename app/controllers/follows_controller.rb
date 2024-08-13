class FollowsController < ApplicationController
  def create
    user_to_follow = User.find(params[:followed_id])
    current_user.followings << user_to_follow
    redirect_to request.referer, status: :see_other
  end

  def destroy
    follow = Follow.find(params[:id])
    follow.destroy
    redirect_to request.referer, status: :see_other
  end
end
