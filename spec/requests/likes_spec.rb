require 'rails_helper'

RSpec.describe "Likes", type: :request do
  let(:user) { create(:user) }

  before do
    post login_path, params: { email: user.email, password: 'password123' }
  end

  describe "シングルバトル" do
    it "シングルバトルいいねページに遷移できること" do
      get single_battle_likes_user_path(user)
      expect(response).to have_http_status(:success)
    end
  end

  describe "ダブルバトル" do
    it "ダブルバトルいいねページに遷移できること" do
      get double_battle_likes_user_path(user)
      expect(response).to have_http_status(:success)
    end
  end
end
