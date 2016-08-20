class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.string :name
      t.integer :level, default: 0
      t.integer :num_vertices
      t.belongs_to :user, index: true
      t.string :colour
      
      t.timestamps null: false
    end
  end
end
