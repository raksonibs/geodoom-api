class CreateBattles < ActiveRecord::Migration
  def change
    create_table :battles do |t|
      t.integer :winner_id
      t.integer :loser_id

      t.timestamps null: false
    end

    create_table :battles_users do |t|
      t.belongs_to :battle, index: true
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
  end
end
