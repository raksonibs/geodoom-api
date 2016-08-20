class AddNameToBattles < ActiveRecord::Migration
  def change
    add_column :battles, :name, :string
  end
end
