FactoryBot.define do
  factory :item do
    sequence(:japanese_name) { |n| "アイテム#{n}" }
    sequence(:english_name) { |n| "item#{n}" }
  end
end
