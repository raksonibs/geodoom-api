class Battle < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_one :winner, class_name: 'Pet', foreign_key: 'winner_id'
  has_one :loser, class_name: 'Pet', foreign_key: 'loser_id'
  has_and_belongs_to_many :pets
  has_one :state

  after_create :set_name, :set_emails, :create_state
  after_update :add_pet

  validate :emails_not_same

  enum status: [:pending, :started, :completed]

  def set_name
    self.update_attributes(name: "Battle number #{id}")
  end

  def create_state
    state = State.find_by({battle_id: self.id}) || State.create({battle_id: self.id})
  end

  def add_pet
    # should broadcast need to refresh browser for battle for user
    pets_found = [Pet.find_by_id(challenged_pet_id), Pet.find_by_id(challenger_pet_id)]

    self.pets = []    

    pets_found.compact.each do |pet|
      pet.battles << self
      self.pets << pet
      pet_state = PetState.find_by({state: state, pet: pet}) || PetState.create(state: state, pet: pet)
      pet_state.update_attributes(current_health: pet.stats.find_by(stat_type: 0).value, current_defence: pet.stats.find_by(stat_type: 2).value, current_attack: pet.stats.find_by(stat_type: 1).value, shield: false)
    end
  end

  def challenger_pet
    Pet.find_by_id(challenger_pet_id)
  end

  def challenged_pet
    Pet.find_by_id(challenged_pet_id)
  end

  def emails_not_same
    errors.add(:challenger_email, "Cannot be the same as challenged email") if challenged_email == challenger_email
  end

  def set_emails
    user = User.find_by_email(challenged_email)
    user_2 = User.find_by_email(challenger_email)

    self.users = []
    # how to remove association? 

    unless user.nil?
      self.users << user
      user.battles << self
    end

    unless user_2.nil?
      self.users << user_2
      user.battles << self
    end
  end
end
