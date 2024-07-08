require 'rails_helper'

RSpec.describe PokemonParty, type: :model do
  let(:build) { create(:build) }
  let(:pokemon) { create(:pokemon) }
  let(:item) { create(:item) }

  it '有効な値な場合、登録できる' do
    pokemon_party = build.pokemon_parties.build(
      pokemon: pokemon,
      item: item,
      pokemon_image_url: 'https://example.com/image.png',
      item_image_url: 'https://example.com/item.png'
    )
    expect(pokemon_party).to be_valid
  end

  it 'ポケモンの選択がない場合、無効であること' do
    pokemon_party = build.pokemon_parties.build(
      item: item,
      pokemon_image_url: 'https://example.com/image.png',
      item_image_url: 'https://example.com/item.png'
    )
    expect(pokemon_party).not_to be_valid
  end

  it '持ち物がない場合、無効であること' do
    pokemon_party = build.pokemon_parties.build(
      pokemon: pokemon,
      pokemon_image_url: 'https://example.com/image.png',
      item_image_url: 'https://example.com/item.png'
    )
    expect(pokemon_party).not_to be_valid
  end

  it '1つの構築記事にポケモンが6体を超えて登録される場合、無効であること' do
    create_list(:pokemon_party, 6, build: build)
    extra_pokemon_party = build.pokemon_parties.build(
      pokemon: pokemon,
      item: item,
      pokemon_image_url: 'https://example.com/image.png',
      item_image_url: 'https://example.com/item.png'
    )
    expect(extra_pokemon_party).not_to be_valid
    expect(extra_pokemon_party.errors[:base]).to include('ポケモンは6体までしか登録できません。')
  end
end
