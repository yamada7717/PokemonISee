require 'rails_helper'

RSpec.describe 'Errors', type: :system do
  let(:user) { create(:user) }

  context 'ログインしている場合' do
    before do
      visit login_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: 'password123'
      click_button 'ログイン'
    end

    it '404エラーページが表示される' do
      visit '/non_existent_page'
      expect(page).to have_content('Not Found')
    end

    it '500エラーページが表示される' do
      allow_any_instance_of(UsersController).to receive(:show).and_raise('意図的なエラー')
      visit user_path(user)
      expect(page).to have_content('Internal Server Error')
    end
  end
end
