FactoryGirl.define do
  factory :alternative do
    content { Faker::Name.name }
    challenge {}
  end
end
