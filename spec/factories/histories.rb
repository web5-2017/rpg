FactoryGirl.define do
  factory :history do
    name    { Faker::Name.name }
    user {}
  end
end
