class PokemonParty < ApplicationRecord
  belongs_to :build
  belongs_to :pokemon
  belongs_to :item
end
