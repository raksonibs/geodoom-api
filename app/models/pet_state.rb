class PetState < ActiveRecord::Base
  belongs_to :pet 
  belongs_to :state
end
