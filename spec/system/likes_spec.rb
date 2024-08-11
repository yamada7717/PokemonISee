require 'rails_helper'

RSpec.describe 'Likes', type: :system do
  let!(:build_owner) { create(:user, name: "Build Owner", email: "owner@example.com") }
  let!(:liking_user) { create(:user, name: "Liking User", email: "liker@example.com") }
  let!(:single_battle_build) { create(:build, :single_battle, user: build_owner) }
  let!(:double_battle_build) { create(:build, :double_battle, user: build_owner) }

  context 'ログインしている場合' do
    before do
      visit login_path
      fill_in "メールアドレス", with: liking_user.email
      fill_in "パスワード", with: "password123"
      click_button "ログイン"
    end

    it 'シングルバトルの構築記事にいいねできること' do
      visit build_path(single_battle_build)
      expect(page).to have_content('いいね')
      click_button 'いいね'
      expect(page).to have_button('いいねを外す')
    end

    it 'シングルバトルの構築記事からいいねを外せること' do
      liking_user.likes.create!(build: single_battle_build)
      visit build_path(single_battle_build)
      expect(page).to have_button('いいねを外す')
      click_button 'いいねを外す'
      expect(page).to have_button('いいね')
    end

    it 'ダブルバトルの構築記事にいいねできること' do
      visit build_path(double_battle_build)
      expect(page).to have_content('いいね')
      click_button 'いいね'
      expect(page).to have_button('いいねを外す')
    end

    it 'ダブルバトルの構築記事からいいねを外せること' do
      liking_user.likes.create!(build: double_battle_build)
      visit build_path(double_battle_build)
      expect(page).to have_button('いいねを外す')
      click_button 'いいねを外す'
      expect(page).to have_button('いいね')
    end

    it 'シングルバトルいいねページに遷移できること' do
      liking_user.likes.create!(build: single_battle_build)
      visit single_battle_likes_user_path(liking_user)
      expect(page).to have_current_path(single_battle_likes_user_path(liking_user))
    end

    it 'シングルバトルいいねページで1件登録がされていることを確認できること' do
      liking_user.likes.create!(build: single_battle_build)
      visit single_battle_likes_user_path(liking_user)
      expect(page).to have_content(single_battle_build.title)
    end

    it 'ダブルバトルいいねページに遷移できること' do
      liking_user.likes.create!(build: double_battle_build)
      visit double_battle_likes_user_path(liking_user)
      expect(page).to have_current_path(double_battle_likes_user_path(liking_user))
    end

    it 'ダブルバトルいいねページで1件登録がされていることを確認できること' do
      liking_user.likes.create!(build: double_battle_build)
      visit double_battle_likes_user_path(liking_user)
      expect(page).to have_content(double_battle_build.title)
    end
  end

  context 'ログインしていない場合' do
    it 'シングルバトルの構築記事にアクセスするとTOPページにリダイレクトされること' do
      visit build_path(single_battle_build)
      expect(page).to have_current_path(root_path)
    end
    it 'ダブルバトルの構築記事にアクセスするとTOPページにリダイレクトされること' do
      visit build_path(double_battle_build)
      expect(page).to have_current_path(root_path)
    end
  end
end
