FactoryGirl.define do
  factory :character do
    name        { Faker::Name.name }
    description { Faker::Name.name }
    breeds { }
  end
end
