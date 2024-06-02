require 'rails_helper'

RSpec.describe 'User', type: :system do
  describe 'ユーザーの新規登録' do
    context 'フォームの入力値が正常なとき' do
      it 'ユーザー登録処理が成功する' do
        visit new_user_path
        click_on "新規登録"
        fill_in "ユーザー名", with: "test_user"
        fill_in "メールアドレス", with: "test@example.com"
        fill_in "パスワード", with: "password123"
        fill_in "パスワードの確認", with: "password123"
        click_button "会員登録"

        expect(page).to have_content "ユーザー登録が完了しました"
        expect(current_path).to eq(root_path)
      end
    end
    context 'フォームの入力値入力値に異常がある場合' do
      it 'ユーザー登録処理が失敗する' do
        visit new_user_path
        click_on "新規登録"
        fill_in "ユーザー名", with: "test_user"
        fill_in "メールアドレス", with: "miss_mail"
        fill_in "パスワード", with: "password"
        fill_in "パスワードの確認", with: "password123"
        click_button "会員登録"

        expect(page).to have_content "メールアドレス の形式が不正です"
        expect(current_path).to eq(users_path)
      end
    end
  end

  describe 'マイページ' do
    let(:user) { create(:user) }

    context 'ログインしている場合' do
      before do
        visit login_path
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: "password123"
        click_button "ログイン"
        visit mypage_user_path(user)
      end

      it 'ログインユーザーとマイページpathが一致している' do
        expect(current_path).to eq(mypage_user_path(user))
      end

      it 'ユーザーネームが表示される' do
        expect(page).to have_content(user.name)
      end

      it '自己紹介が表示される' do
        expect(page).to have_content(user.introduction)
      end
    end

    context 'ログインしていない場合' do
      it 'TOPページにリダイレクトされる' do
        visit mypage_user_path(user)
        expect(current_path).to eq(root_path)
      end
    end
  end

  describe 'プロフィール編集' do
    let(:user) { create(:user) }

    context 'ログインしている場合' do
      before do
        visit login_path
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: "password123"
        click_button "ログイン"
        visit edit_user_path(user)
      end

      it 'ユーザー名が表示される' do
        expect(page).to have_content(user.name)
      end

      it '自己紹介が表示される' do
        expect(page).to have_content(user.introduction)
      end

      it 'メールアドレスが表示される' do
        expect(find_field("メールアドレス").value).to eq(user.email)
      end

      it 'ユーザー情報が更新される' do
        fill_in "ユーザー名", with: "更新後のユーザー名"
        fill_in "自己紹介", with: "更新後の自己紹介"
        click_button "更新"
        page.driver.browser.switch_to.alert.accept
        expect(current_path).to eq(mypage_user_path(user))
        user.reload
        expect(user.name).to eq("更新後のユーザー名")
        expect(user.introduction).to eq("更新後の自己紹介")
      end
    end

    context 'ログインしていない場合' do
      it 'TOPページにリダイレクトされる' do
        visit edit_user_path(user)
        expect(current_path).to eq(root_path)
      end
    end
  end
end
