class FollowsController < ApplicationController
  before_action :set_user

  def create
    current_user.followings << @user
    flash[:notice] = "フォローしました"
    redirect_to @user
  end

  def destroy
    current_user.followings.delete(@user)
    flash[:notice] = "フォローを解除しました"
    redirect_to @user
  end

  private

  def set_user
    @user = User.find(params[:followed_id])
  end
end
