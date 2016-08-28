class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :pet
      t.references :battle
      t.references :user
      t.string :name
      t.float :defenceChange
      t.float :attackChange

      t.timestamps null: false
    end
  end
end
