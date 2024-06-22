require 'rails_helper'

RSpec.describe "UserSessions", type: :request do
  let!(:user) { create(:user) }

  describe 'ログインページ' do
    it 'ログインページが正常に表示されること' do
      get login_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'ログインする際' do
    context '正しい認証情報の場合' do
      it 'ログインに成功し、リダイレクトされること' do
        post login_path, params: { email: user.email, password: 'password123', password_confirmation: 'password123' }
        expect(response).to redirect_to(root_path)
      end
    end

    context '誤った認証情報の場合' do
      it 'ログインに失敗し、ログインページに戻ること' do
        post login_path, params: { email: user.email, password: 'wrongpassword', password_confirmation: 'wrongpassword' }
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'ログアウトする際' do
    it 'ログアウトに成功し、TOPページにリダイレクトされること' do
      get logout_path
      expect(response).to redirect_to(root_path)
      expect(session[:user_id]).to be_nil
    end
  end
end
