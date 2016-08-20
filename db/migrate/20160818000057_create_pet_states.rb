class CreatePetStates < ActiveRecord::Migration
  def change
    create_table :pet_states do |t|
      t.integer :state_id
      t.integer :pet_id
      t.float :current_health
      t.float :current_defence
      t.float :current_attack
      t.boolean :shield

      t.timestamps null: false
    end
  end
end
