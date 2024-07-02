class CreatePokemonParties < ActiveRecord::Migration[7.0]
  def change
    create_table :pokemon_parties do |t|
      t.references :build, null: false, foreign_key: true
      t.references :pokemon, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.string :pokemon_image_url
      t.string :item_image_url

      t.timestamps
    end
  end
end
