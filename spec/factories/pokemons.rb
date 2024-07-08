FactoryBot.define do
  factory :pokemon do
    sequence(:japanese_name) { |n| "ポケモン#{n}" }
    sequence(:english_name) { |n| "pokemon#{n}" }
  end
end
