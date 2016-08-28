class User < ActiveRecord::Base
  has_secure_password
  validates :email, uniqueness: true, presence: true

  has_many :balance_changes
  has_and_belongs_to_many :battles
  has_many :pets, :dependent => :destroy
  has_many :game_stats

  after_create :make_pets, :send_welcome

  has_attached_file :avatar, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  def self.find_or_create_from_auth_hash(hash)
    User.find_by_uid(hash[:uid]) || User.create!({uid: hash[:uid], nickname: hash[:nickname], image: hash[:image], password: 5.times.map{|time| ("A".."z").to_a[rand()*52] }.join(""), email: 5.times.map{|time| ("A".."z").to_a[rand()*52] }.join("")})
  end

  def make_pets
    colours = ["red", "green", "blue", "yellow", "orange", "grey", "purple", "pink", "cyan", "brown"]

    (1..3).each do |time|
      name = 5.times.map{|time| ("A".."z").to_a[rand()*52] }.join("")
      colour = colours[rand() * colours.length]
      verts = rand() * 10
      Pet.create!({user: self, vertices: verts, name: name, colour: colour})
    end
  end

  def follow!(user)
    $redis.multi do 
      $redis.sadd(self.redis_key(:following), user.id)
      $redis.sadd(user.redis_key(:followers), self.id)
    end
  end

  def unfollow!(user)
    $redis.multi do 
      $redis.srem(self.redis_key(:following), user.id)
      $redis.srem(user.redis_key(:followers), self.id)
    end
  end

  def followers
    user_ids = $redis.smembers(self.redis_key(:followers))
    User.where(id: user_ids)
  end

  def following
    user_ids = $redis.smembers(self.redis_key(:following))
    User.where(id: user_ids)
  end

  def friends
    user_ids = $rids.sinter(self.redis_key(:following), self.redis_key(:followers))
    User.where(id: user_ids)
  end

  def redis_key(str)
    "user:#{self.id}:#{str}"
  end

  def send_welcome
    UserMailer.welcome_email(self).deliver
  end
  
end
