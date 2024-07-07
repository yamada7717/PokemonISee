class PokemonParty < ApplicationRecord
  belongs_to :build
  belongs_to :pokemon
  belongs_to :item

  validate :validate_pokemon_limit, on: :create

  private

  def validate_pokemon_limit
    pokemon_count = build.pokemon_parties.count
    if pokemon_count >= 6
      errors.add(:base, 'ポケモンは6体までしか登録できません。')
    end
  end
end
