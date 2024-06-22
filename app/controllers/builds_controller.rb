class BuildsController < ApplicationController
  before_action :require_login
  before_action :set_build, only: %i[show edit update destroy]

  def index
    @builds = Build.all
  end

  def show
  end

  def new
    @build = Build.new
  end

  def edit
  end

  def create
    @build = current_user.builds.new(build_params)
    if @build.save
      # 後ほどポケモン登録機能を実装するため、一旦builds_pathにリダイレクト
      redirect_to builds_path
    else
      render :new
    end
  end

  def update
    if @build.update(build_params)
      redirect_to build_path(@build), notice: '構築記事が更新されました。'
    else
      render :edit
    end
  end

  private

  def set_build
    @build = Build.find(params[:id])
  end

  def build_params
    params.require(:build).permit(:game_type, :title, :introduction, :season, :battle_type, :battle_rank, :battle_rate, :blog_url, :is_public)
  end
end
