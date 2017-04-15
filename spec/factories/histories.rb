FactoryGirl.define do
  factory :history do
    title    { Faker::Name.name }
    user {}
  end
end
