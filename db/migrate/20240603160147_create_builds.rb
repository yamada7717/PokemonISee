class CreateBuilds < ActiveRecord::Migration[7.0]
  def change
    create_table :builds do |t|
      t.references :user, null: false, foreign_key: true
      t.string :game_type
      t.string :title
      t.text :introduction
      t.string :season
      t.string :battle_type
      t.integer :battle_rank
      t.integer :battle_rate
      t.string :blog_url
      t.boolean :is_public

      t.timestamps
    end
  end
end
