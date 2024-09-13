class UserSessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to root_path, notice: "すでにログインしています。"
    end
  end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_to root_path, notice: "ログインしました"
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが違います。"
      render :new
    end
  end

  def guest_login
    @guest_user = User.find_by(email: 'guest@example.com')

    @guest_user ||= User.create!(
      name: 'ゲストユーザー',
      email: 'guest@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
    auto_login(@guest_user)
    redirect_to root_path, notice: 'ゲストログインしました'
  end

  def destroy
    user = current_user
    logout

    if user.email.start_with?('guest_')
      flash[:notice] = 'ログアウトしました。'
    end

    redirect_to root_path, status: :see_other, notice: 'ログアウトしました'
  end
end
