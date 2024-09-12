# db/seeds.rb

usernames = ["サトシ", "カスミ", "タケシ", "ハルカ", "ヒカリ", "セレナ", "シロナ", "レッド", "グリーン", "サカキ"]

10.times do |i|
  User.create!(
    name: usernames[i],
    email: "user#{i}@example.com",
    password: "password",
    password_confirmation: "password"
  )
end
