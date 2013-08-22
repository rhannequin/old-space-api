Kernel::require_relative 'Planet'

class Saturn < Planet

  def initialize
    @urls = [
      'http://www.heavens-above.com/planets.aspx',
      'http://heavens-above.com/planetsummary.aspx'
    ]
    @planet_name = 'saturn'
    @static_values = {
      :semimajor_axis_km           => 1433.53 * (10 ** 6),
      :perihelion                  => 1352.55 * (10 ** 6),
      :aphelion                    => 1514.50 * (10 ** 6),
      :mean_orbital_speed          => 9.69,
      :sidereal_orbit_period       => 10759.22,
      :tropical_orbit_period       => 10746.94,
      :synodic_period              => 378.09,
      :length_of_day               => 10.656,
      :sidereal_rotation_period    => 10.656,
      :obliquity_to_orbit          => 26.73,
      :semimajor_axis_au           => 9.53707032,
      :eccentricity                => 0.05415060,
      :inclination                 => 2.48446,
      :longitude_of_ascending_node => 113.71504,
      :longitude_of_perihelion     => 92.43194,
      :mean_longitude              => 49.94432,
      :discoverer                  => 'Unknown',
      :Date_of_discovery           => 'Classical',
      :mass                        => 5.6846 * (10 ** 26),
      :equatorial_radius           => 60268,
      :polar_radius                => 54364,
      :mean_density                => 687,
      :equatorial_surface_gravity  => 10.44,
      :escape_velocity             => 35.5,
      :blackbody_temp              => 81.1,
      :solar_intensity             => 14.90,
      :natural_satellites          => 47
    }
  end

  def parse
    documents = load
    return @static_values.merge(parse_planets(documents.first))
                         .merge(parse_planet(load.last))
  end

end