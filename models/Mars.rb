Kernel::require_relative 'Planet'

class Mars < Planet

  def initialize
    @urls = [
      'http://www.heavens-above.com/planets.aspx',
      'http://heavens-above.com/planetsummary.aspx'
    ]
    @planet_name = 'mars'
    @static_values = {
      semimajor_axis_km:            227.92 * (10 ** 6),
      perihelion:                   206.62 * (10 ** 6),
      aphelion:                     249.23 * (10 ** 6),
      mean_orbital_speed:           24.13,
      sidereal_orbit_period:        686.980,
      tropical_orbit_period:        686.973,
      synodic_period:               779.94,
      length_of_day:                24.6597,
      sidereal_rotation_period:     24.6229,
      obliquity_to_orbit:           25.19,
      semimajor_axis_au:            1.52366231,
      eccentricity:                 0.09341233,
      inclination:                  1.85061,
      longitude_of_ascending_node:  49.57854,
      longitude_of_perihelion:      336.04084,
      mean_longitude:               355.45332,
      discoverer:                   'Unknown',
      date_of_discovery:            'Classical',
      mass:                         6.4185 * (10 ** 23),
      equatorial_radius:            3397,
      polar_radius:                 3375,
      mean_density:                 5427,
      equatorial_surface_gravity:   3.71,
      escape_velocity:              5.03,
      blackbody_temp:               210.1,
      solar_intensity:              589.2,
      natural_satellites:           2
    }
  end

  def parse
    documents = load
    return @static_values.merge(parse_planets(documents.first))
                         .merge(parse_planet(load.last))
  end

end