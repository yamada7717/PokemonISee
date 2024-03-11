require 'rails_helper'

RSpec.describe 'UserSessions', type: :system do
  let!(:user) { create(:user) }

  describe 'ユーザーがログインする' do
    context 'フォームの入力値が正常なとき' do
      it 'ログインが成功する' do
        visit login_path
        fill_in "メールアドレス", with: "test@example.com"
        fill_in "パスワード", with: "password123"
        click_button "ログイン"

        expect(page).to have_content "ログインしました"
        expect(current_path).to eq(root_path)
      end
    end
    context 'フォームの入力値が異常なとき' do
      it 'ログインが失敗する' do
        visit login_path
        fill_in "メールアドレス", with: ""
        fill_in "パスワード", with: "password123"
        click_button "ログイン"

        expect(page).to have_content "メールアドレスまたはパスワードが違います。"
        expect(current_path).to eq(login_path)
      end
    end
  end
end
