require 'rails_helper'

RSpec.describe "PasswordResets", type: :request do
  let(:user) { create(:user) }

  describe "パスワード変更する" do
    it "有効なメールアドレスでリセットリクエストを送信する" do
      post password_resets_path, params: { email: user.email }
      expect(response).to redirect_to(login_path)
      expect(ActionMailer::Base.deliveries.size).to eq(1)
    end

    it "無効なメールアドレスで変更メールを送信する" do
      post password_resets_path, params: { email: 'invalid@example.com' }
      expect(response).to redirect_to(login_path)
      expect(ActionMailer::Base.deliveries.size).to eq(0)
    end

    it "パスワードリセットリンクにアクセスする" do
      user.deliver_reset_password_instructions!
      get edit_password_reset_path(user.reset_password_token)
      expect(response).to have_http_status(:success)
      expect(response.body).to include("パスワードを変更する")
    end

    it "有効なパスワードでパスワードを更新する" do
      user.deliver_reset_password_instructions!
      old_crypted_password = user.crypted_password
      put password_reset_path(user.reset_password_token), params: { user: { password: 'newpassword', password_confirmation: 'newpassword' } }
      expect(response).to redirect_to(login_path)
      expect(user.reload.crypted_password).to_not eq(old_crypted_password)
    end
  end
end
