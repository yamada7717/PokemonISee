require 'rails_helper'

RSpec.describe "Builds", type: :request do
  let!(:user) { create(:user) }

  describe "GET /builds/new" do
    context "ログインしている場合" do
      before do
        post login_path, params: { email: user.email, password: 'password123' }
      end

      it "投稿ページに遷移できる" do
        get new_build_path
        expect(response).to have_http_status(:success)
      end
    end

    context "ログインしていない場合" do
      it "TOPページににリダイレクトされる" do
        get new_build_path
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
