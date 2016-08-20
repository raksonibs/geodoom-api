class AddChallengerPetAndChallengedPetToBattles < ActiveRecord::Migration
  def change
    add_column :battles, :challenger_pet_id, :integer
    add_column :battles, :challenged_pet_id, :integer
  end
end
