class UserSerializer < ActiveModel::Serializer
  attributes :email, :currency, :online, :nickname, :uid, :image, :avatar

  has_many :pets
  has_many :battles
  has_many :game_stats

  def avatar
    # https://s3-us-west-2.amazonaws.com/badcomics/users/avatars/000/000/001/original/Screen_Shot_2016-08-20_at_11.51.22_AM.png
    object.avatar.url.gsub("//s3.amazonaws.com", "https://s3-us-west-2.amazonaws.com/" )
  end
end
