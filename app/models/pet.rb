class Pet < ActiveRecord::Base
  belongs_to :user
  has_many :stats, :dependent => :destroy
  has_many :pet_states
  has_and_belongs_to_many :battles
  # has_many :items

  after_create :random_stats, :assign_mandatory

  def random_stats
    (0..2).each do |stat_type|
      Stat.create!({value: rand*100, stat_type: stat_type, pet: self})
    end
  end

  def assign_mandatory
    colours = ["red", "green", "blue", "yellow", "orange", "grey", "purple", "pink", "cyan", "brown"]

    update_attributes(vertices: rand*10) if vertices.blank?
    update_attributes(level: 0) if level.blank?
    update_attributes(colour: colours[rand() * colours.length]) if colour.blank?
  end

  def add_item!(item)
    $redis.multi do 
      $redis.sadd(self.redis_key(:items), item.id)
    end
  end

  def remove_item!(item)
    $redis.multi do 
      $redis.srem(self.redis_key(:items), item.id)
    end
  end

  def items
    item_ids = $redis.smembers(self.redis_key(:items))
    Item.where(id: item_ids)
  end

  def has_item?(item)
    # $redis.smembers(self.redis_key(:items)).include?(item.id.to_s)
    $redis.sismember(self.redis_key(:items), item.id)
  end

  def redis_key(str)
    "pet:#{self.id}:#{str}"
  end
end
