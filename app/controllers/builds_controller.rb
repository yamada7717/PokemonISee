class BuildsController < ApplicationController
  before_action :require_login
  before_action :set_build, only: %i[show edit update destroy]

  def index
    @pagy, @builds = pagy(Build.where(is_public: true, battle_type: 'シングル').order(created_at: :desc), limit: 10)

    if params[:user_name].present?
      @builds = @builds.joins(:user).where('users.name LIKE ?', "%#{params[:user_name]}%")
    end
    if params[:pokemon_name].present?
      @builds = @builds.joins(pokemon_parties: :pokemon).where('pokemons.japanese_name LIKE ?', "%#{params[:pokemon_name]}%")
    end
    if params[:battle_rank].present?
      @builds = @builds.where(battle_rank: params[:battle_rank])
    end
    if params[:item_name].present?
      @builds = @builds.joins(pokemon_parties: :item).where('items.japanese_name LIKE ?', "%#{params[:item_name]}%")
    end
    if params[:season].present?
      @builds = @builds.where(season: params[:season])
    end
  end

  def double_battles
    @pagy, @builds = pagy(Build.where(is_public: true, battle_type: 'ダブル').order(created_at: :desc), limit: 10)

    if params[:user_name].present?
      @builds = @builds.joins(:user).where('users.name LIKE ?', "%#{params[:user_name]}%")
    end
    if params[:pokemon_name].present?
      @builds = @builds.joins(pokemon_parties: :pokemon).where('pokemons.japanese_name LIKE ?', "%#{params[:pokemon_name]}%")
    end
    if params[:battle_rank].present?
      @builds = @builds.where(battle_rank: params[:battle_rank])
    end
    if params[:item_name].present?
      @builds = @builds.joins(pokemon_parties: :item).where('items.japanese_name LIKE ?', "%#{params[:item_name]}%")
    end
    if params[:season].present?
      @builds = @builds.where(season: params[:season])
    end
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
      redirect_to new_build_pokemon_party_path(build_id: @build.id)
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
