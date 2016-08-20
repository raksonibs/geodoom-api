class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.integer :stat_type, null: false, default: 0
      t.float :value, null: false
      t.references :pet, null: false
      t.timestamps null: false
    end
  end
end
