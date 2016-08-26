class State < ActiveRecord::Base
  belongs_to :battle
  has_many :pet_states

  after_create :set_turn
  # after_update :update_turn

  def set_turn
    if current_turn.blank?
      user = battle.users.order(:created_at).first
      update_attributes(current_turn: user.id) unless user.blank?
    end
  end
end
