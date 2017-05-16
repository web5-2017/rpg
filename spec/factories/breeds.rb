FactoryGirl.define do
  factory :breed do
    name        { Faker::Name.name }
    description { Faker::Name.name }
    game { }
  end
end
