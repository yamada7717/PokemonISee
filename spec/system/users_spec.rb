require 'rails_helper'

RSpec.describe 'User management', type: :system do
  describe 'ユーザーの新規登録' do
    context 'フォームの入力値が正常なとき' do
      it 'ユーザー登録処理が成功する' do
        visit login_path
        click_on "新規登録"
        fill_in "name", with: "test_user"
        fill_in "email", with: "test@example.com"
        fill_in "password", with: "password123"
        fill_in "password_confirmation", with: "password123"
        click_button "会員登録"

        expect(page).to have_content "ユーザー登録が完了しました"
        expect(current_path).to eq(root_path)
      end
    end
  end
end
