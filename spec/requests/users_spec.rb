require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user) { create(:user) }

  describe "GET /new" do
    it "ユーザー新規作成ページが正常に表示されること" do
      get new_user_path(user)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "ユーザー詳細ページが正常に表示されること" do
      get user_path(user)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /mypage" do
    context "ログインしている場合" do
      before do
        post login_path, params: { email: user.email, password: 'password123' }
      end

      it "ユーザーのマイページが正常に表示されること" do
        get mypage_user_path(user)
        expect(response).to have_http_status(:success)
      end
    end

    context "ログインしていない場合" do
      it "TOPページにリダイレクトされる" do
        get mypage_user_path(user)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
