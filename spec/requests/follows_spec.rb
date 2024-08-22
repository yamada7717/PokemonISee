require 'rails_helper'

RSpec.describe 'Follows', type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user, email: 'other_user@example.com') }

  describe 'フォローページ' do
    context 'ログインしている場合' do
      before do
        post login_path, params: { email: other_user.email, password: 'password123' }
      end

      it 'フォローページに遷移できる' do
        get following_user_path(user)
        expect(response).to have_http_status(:success)
      end
    end

    context 'ログインしていない場合' do
      it 'トップページにリダイレクトされる' do
        get following_user_path(user)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'フォロワーページ' do
    context 'ログインしている場合' do
      before do
        post login_path, params: { email: other_user.email, password: 'password123' }
      end

      it 'フォロワーページに遷移できる' do
        get followers_user_path(user)
        expect(response).to have_http_status(:success)
      end
    end

    context 'ログインしていない場合' do
      it 'トップページにリダイレクトされる' do
        get followers_user_path(user)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
