FactoryGirl.define do
  factory :atm_el do
    name { Faker::App.name }
    chemical_formula { Faker::Lorem.word }
  end
end
