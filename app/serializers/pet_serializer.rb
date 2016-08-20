class PetSerializer < ActiveModel::Serializer
  attributes :id, :name, :level, :colour, :vertices

  has_many :stats
  belongs_to :user
end
