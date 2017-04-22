FactoryGirl.define do
  factory :challenge do
    name        { Faker::Name.name }
    description { Faker::Name.name }
    game { }
    history { }
    alternatives { }
  end
end
