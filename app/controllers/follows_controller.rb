class FollowsController < ApplicationController
  def create
    following = current_user.follows.build(followed_id: params[:user_id])
    following.save
    redirect_to request.referer
  end

  def destroy
    following = current_user.follows.find_by(followed_id: params[:user_id])
    following.destroy
    redirect_to request.referer
  end
end
