class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.float :value

      t.timestamps null: false
    end

    add_reference :game_stats, :game, index: true
    add_foreign_key :game_stats, :games
  end
end
