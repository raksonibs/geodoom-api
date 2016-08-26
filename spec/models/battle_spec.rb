require 'rails_helper'

RSpec.describe Battle, type: :model do
  let(:battle) { create :battle }
  let(:battle_w_pets) { create :battle_w_pets }
  let(:battle_w_users) { create :battle_w_users }

  it "should return true" do 
    expect(Battle.new.valid?).to eq(false)
  end

  it 'status should be pending with zero pets' do 
    expect(battle.status).to eq('pending')
    expect(battle.pets.length).to eq(0)
  end

  it 'after update with challenger email it should have pets' do
    pet = create(:pet)
    expect(battle_w_pets.pets.length).to eq(2);
    battle_w_pets.update(challenged_pet_id: pet.id)
    # deleted both pets
    expect(battle_w_pets.pets.length).to eq(1);
    pet_2 = create(:pet)
    battle_w_pets.update(challenger_pet_id: pet_2.id)
    expect(battle_w_pets.pets.length).to eq(2);
  end

  it 'name should be battle number #[id]' do 
    expect(battle.name).to eq("Battle number #{battle.id}")
  end

  it 'state should be set on creation' do 
    expect(battle.state.battle_id).to eq(battle.id)
    expect(battle.state.current_turn).to eq(nil)
    # tested at phoenix level which handles this logic
  end

  it 'state should be set on creation' do
    battle.update(challenged_email: "oskar@gmail.com")
    battle.update(challenger_email: "oskar@gmail.com")

    expect(battle).to_not be_valid
  end

  it 'set_emails should be nil with no users' do
    battle.update(challenged_email: "oskar@gmail.com")
    battle.update(challenger_email: "oskar@gmail.com")

    expect(battle.valid?).to eq(false)
  end

  it 'set_emails should be nil with no users' do
    user = create(:user, email: 'oskar@gmail.com')
    user_2 = create(:user, email: 'kacper@gmail.com')

    battle.update(challenger_email: user_2.email)
    battle.update(challenged_email: user.email)

    expect(battle.valid?).to eq(true)
    expect(battle.users.length).to eq(2)
  end
end
