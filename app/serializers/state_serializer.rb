class StateSerializer < ActiveModel::Serializer
  attributes :id, :current_turn, :name

  belongs_to :battle
  has_many :pet_states

  def name
    object.battle.name
  end
end
