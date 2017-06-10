FactoryGirl.define do
  factory :skill do
    name          { Faker::Name.name }
    description   { "Descrição" }
    modifier      { "atk:6,mp:10" }
  end
end
