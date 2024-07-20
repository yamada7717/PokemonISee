require 'rails_helper'

RSpec.describe "PokemonParties", type: :system do
  let(:user) { create(:user) }
  let(:build) { create(:build, user: user) }
  let!(:pokemon1) { create(:pokemon, japanese_name: 'ピカチュウ', english_name: 'Pikachu') }
  let!(:pokemon2) { create(:pokemon, japanese_name: 'ディンルー', english_name: 'Ting-lu') }
  let!(:pokemon3) { create(:pokemon, japanese_name: 'フシギダネ', english_name: 'Bulbasaur') }
  let!(:pokemon4) { create(:pokemon, japanese_name: 'ヒトカゲ', english_name: 'Charmander') }
  let!(:pokemon5) { create(:pokemon, japanese_name: 'ゼニガメ', english_name: 'Squirtle') }
  let!(:pokemon6) { create(:pokemon, japanese_name: 'イーブイ', english_name: 'Eevee') }
  let!(:item) { create(:item, japanese_name: 'オボンのみ', english_name: 'Sitrus-berry') }

  describe 'ポケモン検索機能' do
    context 'ログインしている場合' do
      before do
        visit login_path
        fill_in 'email', with: user.email
        fill_in 'password', with: 'password123'
        click_button 'ログイン'
      end

      it '正しいポケモンが登録できる' do
        visit new_build_pokemon_party_path(build)
        fill_in 'search', with: 'ピカチュウ'
        click_button '検索'
        expect(page).to have_content('ピカチュウ')
        select 'オボンのみ', from: 'pokemon_party[item_id]'
        click_button 'ポケモンを追加'
        expect(page).to have_current_path(build_path(build))
        expect(page).to have_content('ピカチュウ')
        expect(page).to have_content('オボンのみ')
      end

      it '6体目までのポケモンが登録できる' do
        [pokemon1, pokemon2, pokemon3, pokemon4, pokemon5].each do |pokemon|
          visit new_build_pokemon_party_path(build)
          fill_in 'search', with: pokemon.japanese_name
          click_button '検索'
          expect(page).to have_content(pokemon.japanese_name)
          select 'オボンのみ', from: 'pokemon_party[item_id]'
          click_button 'ポケモンを追加'
          expect(page).to have_current_path(build_path(build))
          expect(page).to have_content(pokemon.japanese_name)
        end
      end

      it '7体目のポケモンは登録できない' do
        [pokemon1, pokemon2, pokemon3, pokemon4, pokemon5, pokemon6].each do |pokemon|
          visit new_build_pokemon_party_path(build)
          fill_in 'search', with: pokemon.japanese_name
          click_button '検索'
          select 'オボンのみ', from: 'pokemon_party[item_id]'
          click_button 'ポケモンを追加'
        end

        visit new_build_pokemon_party_path(build)
        fill_in 'search', with: 'イーブイ'
        click_button '検索'
        select 'オボンのみ', from: 'pokemon_party[item_id]'
        click_button 'ポケモンを追加'
        expect(page).to have_content('ポケモンは6体までしか登録できません。')
      end
    end

    context 'ログインしていない場合' do
      it 'TOPページにリダイレクトされる' do
        visit new_build_pokemon_party_path(build)
        expect(page).to have_current_path(root_path)
      end
    end
  end
end
