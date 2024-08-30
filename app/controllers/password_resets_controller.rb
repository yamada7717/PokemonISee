class PasswordResetsController < ApplicationController
  def new
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)
    if @user.blank?
      redirect_to login_path, alert: '無効なリンクです。もう一度やり直してください。'
    end
  end

  def create
    @user = User.find_by(email: params[:email])
    @user&.deliver_reset_password_instructions!
    flash[:notice] = 'パスワードリセットのメールを送信しました'
    redirect_to login_path
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)

    if @user.blank?
      not_authenticated
      return
    end

    if params[:user].present?
      @user.password_confirmation = params[:user][:password_confirmation]
      if @user.change_password(params[:user][:password])
        flash[:notice] = 'パスワードがリセットされました。'
        redirect_to login_path
      else
        flash[:alert] = 'パスワードリセットに失敗しました、再度お試しください。'
        render :edit, status: :unprocessable_entity
      end
    else
      flash[:alert] = '無効なリクエストです。'
      render :edit, status: :unprocessable_entity
    end
  end
end
