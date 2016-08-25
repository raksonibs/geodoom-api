require 'rails_helper'

RSpec.describe Battle, type: :model do
  it "should return true" do 
    Battle.new.should_not be_valid
  end
end
