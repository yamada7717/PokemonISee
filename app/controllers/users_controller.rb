class UsersController < ApplicationController
  before_action :require_login, only: %i[show edit destroy update mypage private_builds public_double_builds private_double_builds single_battle_likes double_battle_likes followers following]
  before_action :set_user, only: %i[show edit update destroy mypage private_builds public_double_builds private_double_builds single_battle_likes double_battle_likes followers following]
  before_action :correct_user, only: %i[edit update destroy mypage private_builds private_double_builds]

  def show
    @pagy, @builds = pagy(@user.builds.where(is_public: true, battle_type: 'シングル').order(created_at: :desc), limit: 10)
  end

  def new
    if logged_in?
      redirect_to root_path
    else
      @user = User.new
    end
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to root_path, notice: "ユーザー登録が完了しました"
    else
      render :new
    end
  end

  def update
    if user_params[:password].blank?
      user_params.delete(:password)
      user_params.delete(:password_confirmation)
    end

    if user_params[:remove_profile_image] == "消去"
      @user.profile_image.purge
    end

    if @user.update(user_params)
      redirect_to mypage_user_path(@user), notice: "ユーザー情報を更新しました"
    else
      @user.reload
      render :edit
    end
  end

  def mypage
    @pagy, @builds = pagy(@user.builds.order(created_at: :desc), limit: 10)
  end

  def private_builds
    @pagy, @builds = pagy(@user.builds.where(is_public: false, battle_type: 'シングル').order(created_at: :desc), limit: 10)
  end

  def public_double_builds
    @pagy, @builds = pagy(@user.builds.where(is_public: true, battle_type: 'ダブル').order(created_at: :desc), limit: 10)
  end

  def private_double_builds
    @pagy, @builds = pagy(@user.builds.where(is_public: false, battle_type: 'ダブル').order(created_at: :desc), limit: 10)
  end

  def single_battle_likes
    @pagy, @builds = pagy(@user.liked_builds.where(is_public: true, battle_type: 'シングル').order(created_at: :desc), limit: 10)
  end

  def double_battle_likes
    @pagy, @builds = pagy(@user.liked_builds.where(is_public: true, battle_type: 'ダブル').order(created_at: :desc), limit: 10)
  end

  def followers
    @pagy, @followers = pagy(@user.followers.order(created_at: :desc), items: 30)
    @followers_count = @followers.count
  end

  def following
    @pagy, @followings = pagy(@user.followings.order(created_at: :desc), items: 30)
    @followings_count = @followings.count
  end

  def destroy
    @user.destroy
    reset_session
    redirect_to root_path, notice: "ユーザー情報を削除しました、ご利用ありがとうございました。"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def correct_user
    unless @user == current_user
      redirect_to root_path, alert: "不正なアクセスです。"
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :profile_image, :introduction, :remove_profile_image)
  end
end
