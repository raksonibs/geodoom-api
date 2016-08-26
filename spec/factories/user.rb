FactoryGirl.define do 
  factory :user do     
    sequence(:email) {|n| "oskar#{n}@gmail.com" }
    password "password"
    online false
    uid "76561198077942014"
    nickname "raksonibs"
    image "https://d1ra4hr810e003.cloudfront.net/media/27FB7F0C-9885-42A6-9E0C19C35242B5AC/0/D968A2D0-35B8-41C6-A94A0C5C5FCA0725/F0E9E3EC-8F99-4ED8-A40DADEAF7A011A5/dbe669e9-40be-51c9-a9a0-001b0e022be7/thul-IMG_2100.jpg"
 
  end
end