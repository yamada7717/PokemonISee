class LikesController < ApplicationController
  before_action :require_login
  before_action :set_build

  def create
    @like = current_user.likes.new(build: @build)

    if @like.save
      flash[:notice] = "いいねしました"
    else
      flash[:alert] = "いいねに失敗しました"
    end

    redirect_to build_path(@build)
  end

  def destroy
    @like = current_user.likes.find_by(build: @build)

    if @like.destroy
      flash[:notice] = "いいねを解除しました"
    else
      flash[:alert] = "いいねの解除に失敗しました"
    end

    redirect_to build_path(@build)
  end

  private

  def set_build
    @build = Build.find(params[:build_id])
  end
end
