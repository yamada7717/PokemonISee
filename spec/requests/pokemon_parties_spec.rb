require 'rails_helper'

RSpec.describe "PokemonParties", type: :request do
  let(:user) { create(:user) }
  let(:build) { create(:build, user: user) }
  let(:pokemon_party) { create(:pokemon_party, build: build) }

  describe 'ポケモンパーティ登録ページ' do
    context 'ログインしている場合' do
      before do
        post login_path, params: { email: user.email, password: 'password123' }
      end

      it 'ポケモンパーティ登録ページに遷移できる' do
        get new_build_pokemon_party_path(build)
        expect(response).to have_http_status(:success)
      end
    end

    context 'ログインしていない場合' do
      it 'トップページにリダイレクトされる' do
        get new_build_pokemon_party_path(build)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'ポケモンパーティ編集ページ' do
    context 'ログインしている場合' do
      before do
        post login_path, params: { email: user.email, password: 'password123' }
      end

      it 'ポケモンパーティ編集ページに遷移できる' do
        get edit_build_pokemon_party_path(build, pokemon_party)
        expect(response).to have_http_status(:success)
      end
    end

    context 'ログインしていない場合' do
      it 'トップページにリダイレクトされる' do
        get edit_build_pokemon_party_path(build, pokemon_party)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
