class CreateGameStats < ActiveRecord::Migration
  def change
    create_table :game_stats do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.float :value      

      t.timestamps null: false
    end
  end
end
