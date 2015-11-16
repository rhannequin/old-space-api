FactoryGirl.define do
  factory :planet do
    name { Faker::App.name }
    date_of_discovery { Faker::Lorem.sentence }
    discovered_by { Faker::Lorem.sentence }
    orbit_size { Faker::Number.number(5) }
    mean_orbit_velocity { Faker::Number.decimal(2) }
    orbit_eccentricity { Faker::Number.decimal(2) }
    equatorial_inclination { Faker::Number.decimal(2) }
    equatorial_radius { Faker::Number.decimal(2) }
    equatorial_circumference { Faker::Number.decimal(2) }
    volume { Faker::Number.number(5) }
    mass { Faker::Number.number(5) }
    density { Faker::Number.decimal(2) }
    surface_area { Faker::Number.number(5) }
    surface_gravity { Faker::Number.decimal(2) }
    escape_velocity { Faker::Number.number(5) }
    sidereal_rotation_period { Faker::Number.decimal(2) }
    minimum_surface_temperature { Faker::Number.number(5) }
    maximum_surface_temperature { Faker::Number.number(5) }
  end
end
