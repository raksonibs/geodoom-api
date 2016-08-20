class Stat < ActiveRecord::Base
  enum stat_type: [:health, :attack, :defence]
  belongs_to :pet
  validates :value, presence: true
end
