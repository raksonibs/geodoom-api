FactoryGirl.define do 
  factory :pet do     
    sequence(:name) {|n| "randomname#{n}" }
    vertices 5

  end
end