class Build < ApplicationRecord
  belongs_to :user
  has_many :pokemon_parties, dependent: :destroy

  validates :title, presence: true, length: { maximum: 20 }
  validates :introduction, length: { maximum: 2000 }, allow_blank: true
  validates :season, presence: true
  validates :battle_type, presence: true
  validates :is_public, inclusion: { in: [true, false] }
end
