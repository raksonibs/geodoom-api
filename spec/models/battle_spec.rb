require 'rails_helper'

RSpec.describe Battle, type: :model do
  let(:battle) { build :battle }

  it "should return true" do 
    Battle.new.should_not be_valid
  end

  it 'status should be pending' do 
    expect(battle.status).to eq('pending')
  end
end
