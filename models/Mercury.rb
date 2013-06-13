Kernel::require_relative 'Planet'

class Mercury < Planet

  def initialize
    @urls = [
      'http://www.heavens-above.com/planets.aspx',
      'http://heavens-above.com/planetsummary.aspx'
    ]
    @planet_name = 'mercury'
    @static_values = {
      :semimajor_axis              => 57.91 * (10 ** 6),
      :perihelion                  => 46.00 * (10 ** 6),
      :aphelion                    => 69.82 * (10 ** 6),
      :mean_orbital_speed          => 47.87,
      :sidereal_orbit_period       => 87.969,
      :tropical_orbit_period       => 87.968,
      :synodic_period              => 115.88,
      :length_of_day               => 4222.6,
      :sidereal_rotation_period    => 1407.6,
      :obliquity_to_orbit          => 0.01,
      :semimajor_axis              => 0.38709893,
      :eccentricity                => 0.20563069,
      :inclination                 => 7.00487,
      :longitude_of_ascending_node => 48.33167,
      :longitude_of_perihelion     => 77.45645,
      :mean_longitude              => 252.25084,
      :discoverer                  => 'Unknown',
      :Date_of_discovery           => 'Classical'
    }
  end

  def parse
    documents = load
    return @static_values.merge(parse_planets(documents.first))
                         .merge(parse_planet(load.last))
  end

end