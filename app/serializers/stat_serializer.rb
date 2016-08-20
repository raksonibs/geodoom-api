class StatSerializer < ActiveModel::Serializer
  attributes :id, :stat_type, :value

  belongs_to :pet
end
