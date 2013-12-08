Kernel::require_relative 'Planet'

class Jupiter < Planet

  def initialize
    @urls = [
      'http://www.heavens-above.com/planets.aspx',
      'http://heavens-above.com/planetsummary.aspx'
    ]
    @planet_name = 'jupiter'
    @static_values = {
      semimajor_axis_km:            778.57 * (10 ** 6),
      perihelion:                   740.52 * (10 ** 6),
      aphelion:                     816.62 * (10 ** 6),
      mean_orbital_speed:           13.07,
      sidereal_orbit_period:        4332.589,
      tropical_orbit_period:        4330.595,
      synodic_period:               398.88,
      length_of_day:                9.9259,
      sidereal_rotation_period:     24.6229,
      obliquity_to_orbit:           3.13,
      semimajor_axis_au:            5.20336301,
      eccentricity:                 0.04839266,
      inclination:                  1.30530,
      longitude_of_ascending_node:  100.55615,
      longitude_of_perihelion:      14.75385,
      mean_longitude:               34.40438,
      discoverer:                   'Unknown',
      date_of_discovery:            'Classical',
      mass:                         1.8986 * (10 ** 27),
      equatorial_radius:            71492,
      polar_radius:                 66854,
      mean_density:                 1326,
      equatorial_surface_gravity:   24.79,
      escape_velocity:              59.5,
      blackbody_temp:               110.0,
      solar_intensity:              50.50,
      natural_satellites:           63
    }
  end

  def parse
    documents = load
    return @static_values.merge(parse_planets(documents.first))
                         .merge(parse_planet(load.last))
  end

end