class AddChallengedEmailAndChallengerEmailToBattles < ActiveRecord::Migration
  def change
    add_column :battles, :challenged_email, :string
    add_column :battles, :challenger_email, :string
  end
end
