class Pokemon < ApplicationRecord
  has_many :pokemon_parties, dependent: :destroy
end
