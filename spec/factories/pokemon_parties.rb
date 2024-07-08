FactoryBot.define do
  factory :pokemon_party do
    build
    pokemon
    item
    pokemon_image_url { "https://example.com/image.png" }
    item_image_url { "https://example.com/item.png" }
  end
end
