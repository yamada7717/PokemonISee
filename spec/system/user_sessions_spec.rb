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

  describe 'ゲストログイン機能' do
    context 'ゲストユーザーとしてログインする' do
      it 'ゲストログインが成功する' do
        visit root_path
        click_link 'ゲストログイン'
        expect(page).to have_content 'ゲストログインしました'
        expect(current_path).to eq(root_path)
      end
    end

    context 'ゲストユーザーがログアウトする' do
      it 'ゲストユーザーのログアウトに成功し、アカウントが削除される' do
        visit root_path
        click_link 'ゲストログイン'
        expect(page).to have_content 'ゲストログインしました'
        find('button.dropdown-button').click

        click_link 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
        expect(current_path).to eq(root_path)
      end
    end
  end
end
