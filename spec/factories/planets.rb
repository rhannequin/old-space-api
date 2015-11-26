FactoryGirl.define do
  factory :planet do
    name { Faker::App.name }
    date_of_discovery { Faker::Lorem.sentence }
    discovered_by { Faker::Lorem.sentence }
    orbit_size { Faker::Number.number(5) }
    mean_orbital_velocity { Faker::Number.decimal(2) }
    orbital_eccentricity { Faker::Number.decimal(2) }
    equatorial_inclination { Faker::Number.decimal(2) }
    equatorial_radius { Faker::Number.decimal(2) }
    equatorial_circumference { Faker::Number.decimal(2) }
    volume { BigDecimal(Faker::Number.number(10).to_s) }
    mass { BigDecimal(Faker::Number.number(10).to_s) }
    density { Faker::Number.decimal(2) }
    surface_area { Faker::Number.number(5) }
    surface_gravity { Faker::Number.decimal(2) }
    escape_velocity { Faker::Number.number(5) }
    sidereal_rotation_period { Faker::Number.decimal(2) }
    minimum_surface_temperature { Faker::Number.number(5) }
    maximum_surface_temperature { Faker::Number.number(5) }

    after(:create) do
      create_list(:atm_el, 2)
    end
  end
end
