class Pet < ActiveRecord::Base
  belongs_to :user
  has_many :stats, :dependent => :destroy
  has_many :pet_states
  has_and_belongs_to_many :battles

  after_create :random_stats

  def random_stats
    (0..2).each do |stat_type|
      Stat.create!({value: rand*100, stat_type: stat_type, pet: self})
    end
  end
end
