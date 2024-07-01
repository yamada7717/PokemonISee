require 'json'

# JSONファイルを読み込む
pokemon_data = JSON.parse(File.read(Rails.root.join('db', 'pokemon_sv.json')))

# データベースにポケモンデータを挿入
pokemon_data.each do |pokemon|
  Pokemon.create(japanese_name: pokemon['ja'], english_name: pokemon['en'])
end
