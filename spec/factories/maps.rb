FactoryGirl.define do
  factory :map do
    name       { Faker::Name.name }
    rows       { 10 }
    columns    { 10 }
    history_id {  }
  end
end
