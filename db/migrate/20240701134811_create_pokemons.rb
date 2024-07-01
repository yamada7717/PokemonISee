class CreatePokemons < ActiveRecord::Migration[7.0]
  def change
    create_table :pokemons do |t|
      t.string :japanese_name
      t.string :english_name

      t.timestamps
    end
  end
end
