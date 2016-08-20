class User < ActiveRecord::Base
  has_secure_password
  validates :email, uniqueness: true, presence: true

  has_many :balance_changes
  has_and_belongs_to_many :battles
  has_many :pets
end
