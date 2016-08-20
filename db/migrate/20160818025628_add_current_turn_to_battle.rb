class AddCurrentTurnToBattle < ActiveRecord::Migration
  def change
    add_column :battles, :current_turn, :integer
    add_column :states, :current_turn, :integer
  end
end
