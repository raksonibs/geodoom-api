class CreateTableBattlesPets < ActiveRecord::Migration
  def change
    create_table :battles_pets do |t|
      t.belongs_to :battle, index: true
      t.belongs_to :pet, index: true

      t.timestamps null: false
    end
  end
end
