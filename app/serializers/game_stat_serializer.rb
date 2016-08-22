class GameStatSerializer < ActiveModel::Serializer
  attributes :id, :name, :value

  belongs_to :user
end
