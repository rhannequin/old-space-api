FactoryGirl.define do
  factory :planet do
    name { Faker::App.name.downcase }
  end
end
