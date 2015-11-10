FactoryGirl.define do
  factory :planet do
    name { Faker::App.name.downcase }
    title { Faker::App.name.capitalize }
  end
end
