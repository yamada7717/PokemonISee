class Like < ApplicationRecord
  belongs_to :user
  belongs_to :build

  validates :user_id, uniqueness: { scope: :build_id }
end
