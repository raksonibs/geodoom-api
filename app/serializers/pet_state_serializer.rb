class PetStateSerializer < ActiveModel::Serializer
  attributes :id, :current_health, :current_attack, :current_defence, :shield

  belongs_to :state
  belongs_to :pet
end
