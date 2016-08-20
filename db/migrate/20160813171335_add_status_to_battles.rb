class AddStatusToBattles < ActiveRecord::Migration
  def change
    add_column :battles, :status, :integer, default: 0
  end
end
