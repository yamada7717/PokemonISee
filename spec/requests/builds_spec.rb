require 'rails_helper'

RSpec.describe "Builds", type: :request do
  let!(:user) { create(:user) }
  let(:build) { create(:build, user: user) }

  describe '構築記事投稿ページ' do
    context 'ログインしている場合' do
      before do
        post login_path, params: { email: user.email, password: 'password123' }
      end

      it '投稿ページに遷移できる' do
        get new_build_path
        expect(response).to have_http_status(:success)
      end
    end

    context 'ログインしていない場合' do
      it 'TOPページににリダイレクトされる' do
        get new_build_path
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe '構築記事編集ページ' do
    context 'ログインしている場合' do
      before do
        post login_path, params: { email: user.email, password: 'password123' }
      end

      it '編集ページに遷移できる' do
        get edit_build_path(build)
        expect(response).to have_http_status(:success)
      end
    end

    context 'ログインしていない場合' do
      it 'TOPページにリダイレクトされる' do
        get edit_build_path(build)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe '構築記事詳細ページ' do
    context 'ログインしている場合' do
      before do
        post login_path, params: { email: user.email, password: 'password123' }
      end

      it '詳細ページに遷移できる' do
        get build_path(build)
        expect(response).to have_http_status(:success)
      end
    end

    context 'ログインしていない場合' do
      it 'TOPページにリダイレクトされる' do
        get build_path(build)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'ダブルバトルページ' do
    context 'ログインしている場合' do
      before do
        post login_path, params: { email: user.email, password: 'password123' }
      end

      it 'ダブルバトルページに遷移できる' do
        get double_battles_builds_path
        expect(response).to have_http_status(:success)
      end
    end

    context 'ログインしていない場合' do
      it 'TOPページにリダイレクトされる' do
        get double_battles_builds_path
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
