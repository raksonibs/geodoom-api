class State < ActiveRecord::Base
  belongs_to :battle
  has_many :pet_states

  after_create :set_turn
  # after_update :update_turn

  def set_turn
    if current_turn.blank?
      user = battle.users.order(:created_at).first
      update_attributes(current_turn: user.id)
    end
  end

  def update_turn
    # this is being called after save ha!
    if current_turn.blank?
      new_user = battle.users.order(:created_at).first
    end

    new_user = battle.users.select{|user| user.id != current_turn}.first unless current_turn.blank?

    update_attributes(current_turn: new_user.id)
  end
end
