class BuildsController < ApplicationController
  before_action :require_login

  def index
    @builds = Build.all
  end

  def new
    @build = Build.new
  end

  def create
    @build = current_user.builds.new(build_params)
    if @build.save
      # 後ほどポケモン登録機能を実装するため、一旦builds_pathにリダイレクト
      redirect_to builds_path
    else
      Rails.logger.debug @build.errors.full_messages
      render :new
    end
  end

  private

  def build_params
    params.require(:build).permit(:game_type, :title, :introduction, :season, :battle_type, :battle_rank, :battle_rate, :blog_url, :is_public)
  end
end
