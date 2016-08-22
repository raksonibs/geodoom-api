class UserSerializer < ActiveModel::Serializer
  attributes :email, :currency, :online, :nickname, :uid, :image

  has_many :pets
  has_many :battles
  has_many :game_stats
end
