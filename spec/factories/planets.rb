FactoryGirl.define do
  factory :planet do
    name { Faker::App.name }
    date_of_discovery { Faker::Lorem.sentence }
    discovered_by { Faker::Lorem.sentence }
    orbit_size { Faker::Number.decimal(2) }
    mean_orbit_velocity { Faker::Number.decimal(2) }
    equatorial_radius { Faker::Number.decimal(2) }
    equatorial_circumference { Faker::Number.decimal(2) }
    volume { Faker::Number.number(5) }
    mass { Faker::Number.number(5) }
    surface_area { Faker::Number.decimal(2) }
    escape_velocity { Faker::Number.decimal(2) }
  end
end
