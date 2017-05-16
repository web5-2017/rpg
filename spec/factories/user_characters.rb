FactoryGirl.define do
  factory :user_character do
    name { Faker::Name.name }
    history { Faker::Name.name }
    level { 1 }
    exp { 1 }
    str { 10 }
    dex { 5 }
    con { 3 }
    int { 2 }
    wis { 1 }
    cha { 5 }
    atk { 10 }
    magic_atk { 20 }
    hp { 60 }
    mp { 20 }
    magic_def { 30 }
    confirmed_attributes { true }
    new_character { false }
    user {}
    game {}
    character {}
    breed {}
  end
end
