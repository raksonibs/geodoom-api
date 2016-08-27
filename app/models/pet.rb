class Pet < ActiveRecord::Base
  belongs_to :user
  has_many :stats, :dependent => :destroy
  has_many :pet_states
  has_and_belongs_to_many :battles

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
end
