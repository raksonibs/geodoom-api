class User < ActiveRecord::Base
  has_secure_password
  validates :email, uniqueness: true, presence: true

  has_many :balance_changes
  has_and_belongs_to_many :battles
  has_many :pets
  has_many :game_stats

  def self.find_or_create_from_auth_hash(hash)
    User.find_by_uid(hash[:uid]) || User.create!({uid: hash[:uid], nickname: hash[:nickname], image: hash[:image], password: 5.times.map{|time| ("A".."z").to_a[rand()*52] }.join(""), email: 5.times.map{|time| ("A".."z").to_a[rand()*52] }.join("")})
  end
end
