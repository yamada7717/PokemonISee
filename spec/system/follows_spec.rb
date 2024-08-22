require 'rails_helper'

RSpec.describe 'Follows', type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:user, email: 'other_user@example.com') }

  describe 'フォロー機能' do
    context 'ログインしている場合' do
      before do
        visit login_path
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: "password123"
        click_button "ログイン"
      end

      it 'フォローページに遷移できる' do
        visit following_user_path(user)
        expect(page).to have_content('フォロー中')
      end

      it 'フォロワーページに遷移できる' do
        visit followers_user_path(user)
        expect(page).to have_content('フォロワー')
      end

      it 'ユーザーをフォローできる' do
        visit user_path(other_user)
        click_button 'フォローする'
        expect(page).to have_button('フォローを外す')
        user.reload
        other_user.reload
        expect(user.followings.count).to eq(1)
        expect(other_user.followers.count).to eq(1)
      end

      it 'ユーザーをフォロー解除できる' do
        user.followings << other_user
        visit user_path(other_user)
        click_button 'フォローを外す'
        expect(page).to have_button('フォローする')
        user.reload
        other_user.reload
        expect(user.followings.count).to eq(0)
        expect(other_user.followers.count).to eq(0)
      end
    end

    context 'ログインしていない場合' do
      it 'TOPページにリダイレクトされる' do
        visit following_user_path(user)
        expect(current_path).to eq(root_path)
      end
    end
  end
end
