require 'json'

# JSONファイルを読み込む
item_data = JSON.parse(File.read(Rails.root.join('db', 'item.json')))

# データベースにポケモンデータを挿入
item_data.each do |item|
  Item.create(japanese_name: item['ja'], english_name: item['en'])
end
