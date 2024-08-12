class FollowsController < ApplicationController
  def create
    user_to_follow = User.find(params[:followed_id])
    current_user.followings << user_to_follow
    redirect_to user_path(user_to_follow), notice: 'フォローしました'
  end

  def destroy
    follow = Follow.find(params[:id])
    follow.destroy
    redirect_to user_path(follow.followed), notice: 'フォローをはずしました'
  end
end
