# This will guess the User class
FactoryGirl.define do
  factory :user do
    name                  { Faker::Name.name }
    email                 { Faker::Internet.email }
    password              { 123456 }
    password_confirmation { 123456 }

    factory :user_actived do
      confirmed_at Time.now
    end
  end
end
