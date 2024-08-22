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

      it 'アカウントが削除できる' do
        click_button 'アカウントを削除'
        page.driver.browser.switch_to.alert.accept
        sleep 1
        expect(current_path).to eq(root_path)
        expect(User.exists?(user.id)).to be_falsey
      end
    end

    context 'ログインしていない場合' do
      it 'TOPページにリダイレクトされる' do
        visit edit_user_path(user)
        expect(current_path).to eq(root_path)
      end
    end
  end

  describe 'ユーザー詳細ページ' do
    let(:user) { create(:user) }
    let!(:single_build) { create(:build, user: user, battle_type: 'シングル', is_public: true) }
    let!(:double_build) { create(:build, user: user, battle_type: 'ダブル', is_public: true) }

    context 'ログインしている場合' do
      before do
        visit login_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'password123'
        click_button 'ログイン'
        visit user_path(user)
      end

      it 'ユーザー詳細ページに遷移できる' do
        expect(current_path).to eq(user_path(user))
      end

      it 'ユーザー名が表示される' do
        expect(page).to have_content(user.name)
      end

      it 'シングルバトル公開構築記事が表示されているか' do
        expect(page).to have_content(single_build.title)
      end

      it 'ダブルバトル公開記事に遷移できる' do
        visit double_battles_builds_path
        expect(current_path).to eq(double_battles_builds_path)
      end

      it 'ダブルバトル公開記事が表示されているか' do
        visit double_battles_builds_path
        expect(page).to have_content(double_build.title)
      end
    end

    context 'ログインしていない場合' do
      it 'ユーザー詳細ページにアクセスできない' do
        visit user_path(user)
        expect(current_path).to eq(root_path)
      end
    end
  end

  describe 'プライベート構築記事一覧ページ' do
    let(:user) { create(:user) }
    let!(:private_build) { create(:build, user: user, is_public: false) }

    context 'ログインしている場合' do
      before do
        visit login_path
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: "password123"
        click_button "ログイン"
        visit private_builds_user_path(user)
      end

      it 'プライベート構築記事一覧ページに遷移できる' do
        expect(current_path).to eq(private_builds_user_path(user))
      end

      it 'プライベート構築記事が表示される' do
        expect(page).to have_content(private_build.title)
      end
    end

    context 'ログインしていない場合' do
      it 'TOPページにリダイレクトされる' do
        visit private_builds_user_path(user)
        expect(current_path).to eq(root_path)
      end
    end
  end

  describe '公開ダブルバトル構築記事一覧ページ' do
    let(:user) { create(:user) }
    let!(:public_double_build) { create(:build, user: user, is_public: true, battle_type: 'ダブル') }

    context 'ログインしている場合' do
      before do
        visit login_path
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: "password123"
        click_button "ログイン"
        visit public_double_builds_user_path(user)
      end

      it '公開ダブルバトル構築記事一覧ページに遷移できる' do
        expect(current_path).to eq(public_double_builds_user_path(user))
      end

      it '公開ダブルバトル構築記事が表示される' do
        expect(page).to have_content(public_double_build.title)
      end
    end

    context 'ログインしていない場合' do
      it 'TOPページにリダイレクトされる' do
        visit public_double_builds_user_path(user)
        expect(current_path).to eq(root_path)
      end
    end
  end

  describe 'プライベートダブルバトル構築記事一覧ページ' do
    let(:user) { create(:user) }
    let!(:private_double_build) { create(:build, user: user, is_public: false, battle_type: 'ダブル') }

    context 'ログインしている場合' do
      before do
        visit login_path
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: "password123"
        click_button "ログイン"
        visit private_double_builds_user_path(user)
      end

      it 'プライベートダブルバトル構築記事一覧ページに遷移できる' do
        expect(current_path).to eq(private_double_builds_user_path(user))
      end

      it 'プライベートダブルバトル構築記事が表示される' do
        expect(page).to have_content(private_double_build.title)
      end
    end

    context 'ログインしていない場合' do
      it 'TOPページにリダイレクトされる' do
        visit private_double_builds_user_path(user)
        expect(current_path).to eq(root_path)
      end
    end
  end
end
