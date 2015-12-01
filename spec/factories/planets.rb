FactoryGirl.define do
  factory :planet do
    name { Faker::App.name }
    date_of_discovery { Faker::Lorem.sentence }
    discovered_by { Faker::Lorem.sentence }
    mean_orbit_size { Faker::Number.number(5) }
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
    polar_radius { Faker::Number.decimal(2) }
    volumetric_mean_radius { Faker::Number.decimal(2) }
    ellipticity { Faker::Number.decimal(2) }
    acceleration { Faker::Number.decimal(2) }
    standard_gravitational_parameter { Faker::Number.decimal(2) }
    bond_albedo { Faker::Number.decimal(2) }
    visual_geometric_albedo { Faker::Number.decimal(2) }
    visual_magnitude { Faker::Number.decimal(2) }
    solar_irradiance { Faker::Number.decimal(2) }
    black_body_temperature { Faker::Number.decimal(2) }
    semimajor_axis { Faker::Number.number(5) }
    sidereal_orbital_period { Faker::Number.decimal(2) }
    tropical_orbital_period { Faker::Number.decimal(2) }
    perihelion { Faker::Number.number(5) }
    aphelion { Faker::Number.number(5) }
    maximum_orbital_velocity { Faker::Number.decimal(2) }
    minimum_orbital_velocity { Faker::Number.decimal(2) }
    orbital_inclination { Faker::Number.decimal(2) }
    length_of_day { Faker::Number.decimal(2) }

    after(:create) do
      create_list(:atm_el, 2)
    end
  end
end
