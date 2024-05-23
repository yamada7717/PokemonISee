class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = current_user
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
    @user = current_user
    if user_params[:password].blank?
      user_params.delete(:password)
      user_params.delete(:password_confirmation)
    end

    if @user.update(user_params)
      redirect_to mypage_user_path(@user), notice: "ユーザー情報を更新しました"
    else
      @user.reload
      render :edit
    end
  end

  def mypage
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :profile_image, :introduction)
  end
end
