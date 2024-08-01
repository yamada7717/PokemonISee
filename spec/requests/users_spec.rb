require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user) { create(:user) }
  let!(:public_single_build) { create(:build, user: user, is_public: true, battle_type: 'シングル') }
  let!(:private_single_build) { create(:build, user: user, is_public: false, battle_type: 'シングル') }
  let!(:public_double_build) { create(:build, user: user, is_public: true, battle_type: 'ダブル') }
  let!(:private_double_build) { create(:build, user: user, is_public: false, battle_type: 'ダブル') }

  describe "新規登録" do
    it "ユーザー新規作成ページが正常に表示されること" do
      get new_user_path(user)
      expect(response).to have_http_status(:success)
    end
  end

  describe "ユーザーページ" do
    context "ログインしている場合" do
      before do
        post login_path, params: { email: user.email, password: 'password123' }
      end
      it "ユーザー詳細ページが正常に表示されること" do
        get user_path(user)
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "マイページ" do
    context "ログインしている場合" do
      before do
        post login_path, params: { email: user.email, password: 'password123' }
      end

      it "ユーザーのマイページが正常に表示されること" do
        get mypage_user_path(user)
        expect(response).to have_http_status(:success)
        expect(response.body).to include(public_single_build.title)
      end
    end

    context "ログインしていない場合" do
      it "TOPページにリダイレクトされる" do
        get mypage_user_path(user)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "非公開シングルバトルページ" do
    context "ログインしている場合" do
      before do
        post login_path, params: { email: user.email, password: 'password123' }
      end

      it "非公開シングルバトルページに遷移できる" do
        get private_builds_user_path(user)
        expect(response).to have_http_status(:success)
        expect(response.body).to include(private_single_build.title)
      end
    end

    context "ログインしていない場合" do
      it "TOPページにリダイレクトされる" do
        get private_builds_user_path(user)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "公開ダブルバトルページ" do
    context "ログインしている場合" do
      before do
        post login_path, params: { email: user.email, password: 'password123' }
      end

      it "公開ダブルバトルページに遷移できる" do
        get public_double_builds_user_path(user)
        expect(response).to have_http_status(:success)
        expect(response.body).to include(public_double_build.title)
      end
    end

    context "ログインしていない場合" do
      it "TOPページにリダイレクトされる" do
        get public_double_builds_user_path(user)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "非公開ダブルバトルページ" do
    context "ログインしている場合" do
      before do
        post login_path, params: { email: user.email, password: 'password123' }
      end

      it "非公開ダブルバトルページに遷移できる" do
        get private_double_builds_user_path(user)
        expect(response).to have_http_status(:success)
        expect(response.body).to include(private_double_build.title)
      end
    end

    context "ログインしていない場合" do
      it "TOPページにリダイレクトされる" do
        get private_double_builds_user_path(user)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
