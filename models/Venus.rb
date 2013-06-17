Kernel::require_relative 'Planet'

class Venus < Planet

  def initialize
    @urls = [
      'http://www.heavens-above.com/planets.aspx',
      'http://heavens-above.com/planetsummary.aspx'
    ]
    @planet_name = 'venus'
    @static_values = {
      :semimajor_axis              => 108.21 * (10 ** 6),
      :perihelion                  => 107.48 * (10 ** 6),
      :aphelion                    => 108.94 * (10 ** 6),
      :mean_orbital_speed          => 35.02,
      :sidereal_orbit_period       => 224.701,
      :tropical_orbit_period       => 224.695,
      :synodic_period              => 583.92,
      :length_of_day               => 2802,
      :sidereal_rotation_period    => -5832.5,
      :obliquity_to_orbit          => 177.36,
      :semimajor_axis              => 0.72333199,
      :eccentricity                => 0.00677323,
      :inclination                 => 3.39471,
      :longitude_of_ascending_node => 76.68069,
      :longitude_of_perihelion     => 131.53298,
      :mean_longitude              => 181.97973,
      :discoverer                  => 'Unknown',
      :Date_of_discovery           => 'Classical',
      :mass                        => 4.8685 * (10 ** 24),
      :equatorial_radius           => 6051.8,
      :polar_radius                => 6051.8,
      :mean_density                => 5243,
      :equatorial_surface_gravity  => 8.87,
      :escape_velocity             => 10.36,
      :blackbody_temp              => 231.7,
      :solar_intensity             => 2613.9,
      :natural_satellites          => 0
    }
  end

  def parse
    documents = load
    return @static_values.merge(parse_planets(documents.first))
                         .merge(parse_planet(load.last))
  end

end