# spec/system/builds_spec.rb
require 'rails_helper'

RSpec.describe 'Builds', type: :system do
  let(:user) { create(:user) }
  let(:valid_build) { create(:build, user: user) }
  let!(:build) { create(:build, user: user) }
  let!(:double_battle_build) { create(:build, user: user, battle_type: 'ダブル') }

  describe '構築記事投稿の新規作成' do
    context 'ログインしている場合' do
      before do
        visit login_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'password123'
        click_button 'ログイン'
        visit new_build_path
      end

      it '投稿ページに遷移できる' do
        visit new_build_path
        expect(page).to have_current_path(new_build_path)
        expect(page).to have_content('構築記事の登録')
      end

      it '投稿処理が成功する' do
        fill_in '構築タイトル', with: valid_build.title
        fill_in '構築紹介', with: valid_build.introduction
        fill_in 'シーズン', with: valid_build.season
        choose valid_build.battle_type
        fill_in '順位', with: valid_build.battle_rank
        fill_in 'バトルレート', with: valid_build.battle_rate
        fill_in 'ブログURL', with: valid_build.blog_url
        choose '公開する' if valid_build.is_public
        click_button 'ポケモンパーティ登録へ'
        build = Build.last
        expect(build.title).to eq(valid_build.title)
        expect(build.introduction).to eq(valid_build.introduction)
        expect(build.user).to eq(user)
        expect(page).to have_current_path(new_build_pokemon_party_path(build_id: build.id))
      end

      it '無効な入力で構築記事投稿作成が失敗する' do
        visit new_build_path
        fill_in '構築タイトル', with: ''
        fill_in '構築紹介', with: ''
        click_button 'ポケモンパーティ登録へ'
        expect(page).to have_current_path(builds_path)
      end
    end

    context 'ログインしていない場合' do
      it '新規構築記事投稿ページにアクセスするとトップページにリダイレクトされる' do
        visit new_build_path
        expect(page).to have_current_path(root_path)
      end
    end
  end

  describe '構築記事一覧ページ' do
    context 'ログインしている場合' do
      before do
        visit login_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'password123'
        click_button 'ログイン'
        visit builds_path
      end

      it '一覧ページに遷移できる' do
        expect(page).to have_current_path(builds_path)
      end

      it '投稿タイトルが表示される' do
        expect(page).to have_content(build.title)
      end

      it '投稿者名が表示される' do
        expect(page).to have_content(build.user.name)
      end

      it '投稿日が表示される' do
        expect(page).to have_content(build.created_at.strftime("%Y年%m月%d日"))
      end

      it 'シーズンが表示される' do
        expect(page).to have_content(build.season)
      end

      it '順位が表示される' do
        expect(page).to have_content(build.battle_rank)
      end
    end

    context 'ログインしていない場合' do
      it '一覧ページにアクセスするとTOPページにリダイレクトされる' do
        visit builds_path
        expect(page).to have_current_path(root_path)
      end
    end
  end

  describe '構築記事編集ページ' do
    context 'ログインしている場合' do
      before do
        visit login_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'password123'
        click_button 'ログイン'
        visit edit_build_path(build)
      end

      it '編集ページに遷移できる' do
        expect(page).to have_current_path(edit_build_path(build))
        expect(page).to have_content('構築記事の編集')
      end

      it '更新できる' do
        fill_in '構築タイトル', with: '新しいタイトル'
        fill_in '構築紹介', with: '新しい紹介'
        click_button '更新'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_current_path(build_path(build))
        build.reload
        expect(build.title).to eq('新しいタイトル')
        expect(build.introduction).to eq('新しい紹介')
      end
    end

    context 'ログインしていない場合' do
      it '編集ページにアクセスするとトップページにリダイレクトされる' do
        visit edit_build_path(build)
        expect(page).to have_current_path(root_path)
      end
    end
  end

  describe '構築記事詳細ページ' do
    context 'ログインしている場合' do
      before do
        visit login_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'password123'
        click_button 'ログイン'
        visit build_path(build)
      end

      it '詳細ページに遷移できる' do
        expect(page).to have_current_path(build_path(build))
      end

      it '投稿タイトルが表示される' do
        expect(page).to have_content(build.title)
      end

      it '投稿紹介が表示される' do
        expect(page).to have_content(build.introduction)
      end

      it '投稿者名が表示される' do
        expect(page).to have_content(build.user.name)
      end

      it '投稿日が表示される' do
        expect(page).to have_content(build.created_at.strftime("%Y年%m月%d日"))
      end

      it 'シーズンが表示される' do
        expect(page).to have_content(build.season)
      end

      it 'バトルレートが表示される' do
        expect(page).to have_content(build.battle_rate)
      end

      it '順位が表示される' do
        expect(page).to have_content(build.battle_rank)
      end

      it 'バトルタイプが表示される' do
        expect(page).to have_content(build.battle_type)
      end

      it 'ブログURLが表示される' do
        expect(page).to have_content(build.blog_url)
      end
    end

    context 'ログインしていない場合' do
      it '詳細ページにアクセスするとトップページにリダイレクトされる' do
        visit build_path(build)
        expect(page).to have_current_path(root_path)
      end
    end
  end

  describe 'ダブルバトルページに関するテスト' do
    context 'ログインしている場合' do
      before do
        visit login_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'password123'
        click_button 'ログイン'
        visit double_battles_builds_path
      end

      it 'ダブルバトルページに遷移できる' do
        expect(page).to have_current_path(double_battles_builds_path)
      end

      it '投稿タイトルが表示される' do
        expect(page).to have_content(double_battle_build.title)
      end

      it '投稿者名が表示される' do
        expect(page).to have_content(double_battle_build.user.name)
      end

      it '投稿日が表示される' do
        expect(page).to have_content(double_battle_build.created_at.strftime("%Y年%m月%d日"))
      end

      it 'シーズンが表示される' do
        expect(page).to have_content(double_battle_build.season)
      end

      it '順位が表示される' do
        expect(page).to have_content(double_battle_build.battle_rank)
      end
    end

    context 'ログインしていない場合' do
      it 'ダブルバトルページにアクセスできない' do
        visit double_battles_builds_path
        expect(page).to have_current_path(root_path)
      end
    end
  end
end
