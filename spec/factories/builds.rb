FactoryBot.define do
  factory :build do
    title { 'タイトル' }
    introduction { '構築紹介の内容です。' }
    game_type { 'SV' }
    season { 1 }
    battle_rank { 100 }
    battle_rate { 1500 }
    blog_url { 'http://example.com' }
    is_public { true }
    association :user

    trait :single_battle do
      battle_type { 'シングル' }
    end

    trait :double_battle do
      battle_type { 'ダブル' }
    end
  end
end
