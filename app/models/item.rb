class Item < ApplicationRecord
  has_many :pokemon_parties, dependent: :destroy
end
