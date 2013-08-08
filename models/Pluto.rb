Kernel::require_relative 'Planet'

class Pluto < Planet

  def initialize
    @urls = [
      'http://www.heavens-above.com/planets.aspx',
      'http://heavens-above.com/planetsummary.aspx'
    ]
    @planet_name = 'pluto'
    @static_values = {
      :semimajor_axis              => 5906.38 * (10 ** 6),
      :perihelion                  => 4436.82 * (10 ** 6),
      :aphelion                    => 7375.93 * (10 ** 6),
      :mean_orbital_speed          => 4.72,
      :sidereal_orbit_period       => 90465,
      :tropical_orbit_period       => 90588,
      :synodic_period              => 366.73,
      :length_of_day               => 153.2820,
      :sidereal_rotation_period    => -153.2928,
      :obliquity_to_orbit          => 122.53,
      :semimajor_axis              => 39.48168677,
      :eccentricity                => 0.24880766,
      :inclination                 => 17.14175,
      :longitude_of_ascending_node => 110.30347,
      :longitude_of_perihelion     => 224.06676,
      :mean_longitude              => 238.92881,
      :discoverer                  => 'Clyde Tombaugh',
      :Date_of_discovery           => '1930-02-18',
      :mass                        => 1.25 * (10 ** 22),
      :equatorial_radius           => 1195,
      :polar_radius                => 1195,
      :mean_density                => 1750,
      :equatorial_surface_gravity  => 0.58,
      :escape_velocity             => 1.2,
      :blackbody_temp              => 37.5,
      :solar_intensity             => 0.89,
      :natural_satellites          => 3
    }
  end

  def parse
    documents = load
    return @static_values.merge(parse_planets(documents.first))
                         .merge(parse_planet(load.last))
  end

end