class UsersController < ApplicationController
  before_action :require_login, only: %i[edit update mypage]
  before_action :set_current_user, only: %i[edit update mypage]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
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
  end

  private

  def set_current_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :profile_image, :introduction, :remove_profile_image)
  end
end
