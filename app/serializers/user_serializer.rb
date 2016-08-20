class UserSerializer < ActiveModel::Serializer
  attributes :email, :currency, :online

  has_many :pets
  has_many :battles
end
