FactoryGirl.define do 
  factory :battle do 
    sequence(:name) {|n| "Battle Name #{n}" }
    challenger_email "oskar@gmail.com"
    challenged_email "kacper@gmail.com"

    factory :battle_w_pets do 
      transient do 
        pets_count 2
      end

      after(:create) do |battle, evaluator|
        pets = create_list(:pet, evaluator.pets_count)

        pets.each do |pet|
          battle.pets << pet
        end
      end
    end

    factory :battle_w_users do 
      transient do 
        pets_count 2
      end

      after(:create) do |battle, evaluator|
        pets = create_list(:user, evaluator.users_count)

        users.each do |user|
          battle.users << user
        end
      end
    end
  end
end