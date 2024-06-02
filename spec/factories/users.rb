FactoryBot.define do
  factory :user do
    name { "test_user" }
    email { "test@example.com" }
    password { "password123" }
    password_confirmation { "password123" }
    introduction { "自己紹介" }
  end
end
