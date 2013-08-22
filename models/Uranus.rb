Kernel::require_relative 'Planet'

class Uranus < Planet

  def initialize
    @urls = [
      'http://www.heavens-above.com/planets.aspx',
      'http://heavens-above.com/planetsummary.aspx'
    ]
    @planet_name = 'uranus'
    @static_values = {
      :semimajor_axis_km           => 2872.46 * (10 ** 6),
      :perihelion                  => 2741.30 * (10 ** 6),
      :aphelion                    => 3003.62 * (10 ** 6),
      :mean_orbital_speed          => 6.81,
      :sidereal_orbit_period       => 30685.4,
      :tropical_orbit_period       => 30588.74,
      :synodic_period              => 369.66,
      :length_of_day               => 17.24,
      :sidereal_rotation_period    => 17.24,
      :obliquity_to_orbit          => 97.77,
      :semimajor_axis_au           => 19.19126393,
      :eccentricity                => 0.04716771,
      :inclination                 => 0.76986,
      :longitude_of_ascending_node => 74.22988,
      :longitude_of_perihelion     => 170.96424,
      :mean_longitude              => 313.23218,
      :discoverer                  => 'William Herschel',
      :Date_of_discovery           => '1781-03-13',
      :mass                        => 8.6832 * (10 ** 25),
      :equatorial_radius           => 25559,
      :polar_radius                => 24973,
      :mean_density                => 1270,
      :equatorial_surface_gravity  => 8.87,
      :escape_velocity             => 21.3,
      :blackbody_temp              => 58.2,
      :solar_intensity             => 3.71,
      :natural_satellites          => 27
    }
  end

  def parse
    documents = load
    return @static_values.merge(parse_planets(documents.first))
                         .merge(parse_planet(load.last))
  end

end