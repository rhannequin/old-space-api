Kernel::require_relative 'Planet'

class Earth < Planet

  def initialize
    @urls = %w(http://www.heavens-above.com/planets.aspx)
    @planet_name = 'earth'
    @static_values = {
      semimajor_axis_km:            149.60 * (10 ** 6),
      perihelion:                   147.09 * (10 ** 6),
      aphelion:                     152.10 * (10 ** 6),
      mean_orbital_speed:           29.78,
      sidereal_orbit_period:        365.256,
      tropical_orbit_period:        365.242,
      length_of_day:                24.0000,
      sidereal_rotation_period:     23.9345,
      obliquity_to_orbit:           23.45,
      semimajor_axis_au:            1.00000011,
      eccentricity:                 0.01671022,
      inclination:                  0.00005,
      longitude_of_ascending_node:  -11.26064,
      longitude_of_perihelion:      102.94719,
      mean_longitude:               100.46435,
      mass:                         5.9736 * (10 ** 24),
      equatorial_radius:            6378.1,
      polar_radius:                 6356.8,
      mean_density:                 5515,
      surface_gravity:              9.798,
      escape_velocity:              11.186,
      blackbody_temp:               254.3,
      solar_intensity:              1367.6,
      natural_satellites:           1
    }
  end

  def parse
    documents = load
    return @static_values.merge(parse_planets(documents.first))
  end

end