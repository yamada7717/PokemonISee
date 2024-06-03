FactoryBot.define do
  factory :build do
    user_id { 1 }
    title { "MyString" }
    introduction { "MyText" }
    season { "MyString" }
    game_type { "MyString" }
    battle_type { "MyString" }
    battle_rank { 1 }
    battle_rate { 1 }
    blog_url { "MyString" }
    is_public { false }
  end
end
