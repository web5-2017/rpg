# This will guess the User class
FactoryGirl.define do
  factory :game do
    name    { Faker::Name.name }
    user {}

  end
end
