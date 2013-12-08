Kernel::require_relative 'Planet'

class Neptune < Planet

  def initialize
    @urls = [
      'http://www.heavens-above.com/planets.aspx',
      'http://heavens-above.com/planetsummary.aspx'
    ]
    @planet_name = 'neptune'
    @static_values = {
      semimajor_axis_km:            4495.06 * (10 ** 6),
      perihelion:                   4444.45 * (10 ** 6),
      aphelion:                     4545.67 * (10 ** 6),
      mean_orbital_speed:           5.43,
      sidereal_orbit_period:        60189.0,
      tropical_orbit_period:        59799.9,
      synodic_period:               367.49,
      length_of_day:                16.11,
      sidereal_rotation_period:     16.11,
      obliquity_to_orbit:           28.32,
      semimajor_axis_au:            30.06896348,
      eccentricity:                 0.00858587,
      inclination:                  1.76917,
      longitude_of_ascending_node:  131.72169,
      longitude_of_perihelion:      44.97135,
      mean_longitude:               304.88003,
      discoverer:                   'Johann Gottfried Galle',
      date_of_discovery:            '1846-09-23',
      mass:                         1.0243 * (10 ** 26),
      equatorial_radius:            24764,
      polar_radius:                 24341,
      mean_density:                 1638,
      equatorial_surface_gravity:   11.15,
      escape_velocity:              23.5,
      blackbody_temp:               46.6,
      solar_intensity:              1.51,
      natural_satellites:           13
    }
  end

  def parse
    documents = load
    return @static_values.merge(parse_planets(documents.first))
                         .merge(parse_planet(load.last))
  end

end