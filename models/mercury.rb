class Mercury
  include Mongoid::Document

  field :urls                            , type: Array
  field :discovered_by                   , type: String
  field :date_of_discovery               , type: String
  field :semi_major_axis                 , type: Integer
  field :perihelion                      , type: Integer
  field :aphelion                        , type: Integer
  field :orbit_circumference             , type: Float
  field :average_orbit_velocity          , type: Float
  field :mean_orbital_speed              , type: Float
  field :sidereal_orbit_period           , type: Float
  field :tropical_orbit_period           , type: Float
  field :synodic_period                  , type: Float
  field :orbit_eccentricity              , type: Float
  field :orbit_inclination               , type: Float
  field :equatorial_inclination_to_orbit , type: Float
  field :longitude_of_ascending_node     , type: Float
  field :longitude_of_perihelion         , type: Float
  field :mean_longitude                  , type: Float
  field :mean_radius                     , type: Float
  field :equatorial_circumference        , type: Float
  field :volume                          , type: Float
  field :mass                            , type: Float
  field :density                         , type: Float
  field :surface_area                    , type: Integer
  field :surface_gravity                 , type: Float
  field :escape_velocity                 , type: Integer
  field :sidereal_rotation_period        , type: Float
  field :minimum_surface_temperature     , type: Integer
  field :maximum_surface_temperature     , type: Integer
  field :solar_intensity                 , type: Float
  field :natural_satellites              , type: Integer
  field :atmospheric_constituents        , type: Array

  def self.prepare
    self.delete_all
    self.create initial_values
  end

  def self.initial_values
    {
      urls:                            ['http://solarsystem.nasa.gov/planets/profile.cfm?Object=Mercury&Display=Facts',
                                        'http://www.heavens-above.com/mercury.aspx'],
      discovered_by:                   'Known by the Ancients',
      date_of_discovery:               'Unknown',
      semi_major_axis:                 5.7909227 * (10 ** 7), # km
      perihelion:                      4.6 * (10 ** 7),       # km
      aphelion:                        6.982 * (10 ** 7),     # km
      orbit_circumference:             3.600 * (10 ** 8),     # km
      average_orbit_velocity:          4.7362,                # m/s
      mean_orbital_speed:              47.87,                 # km/s
      sidereal_orbit_period:           87.969,                # days
      tropical_orbit_period:           87.968,                # days
      synodic_period:                  115.88,                # days
      orbit_eccentricity:              0.20563593,
      orbit_inclination:               7.0,                   # °
      equatorial_inclination_to_orbit: 0,                     # °
      longitude_of_ascending_node:     48.33167,              # °
      longitude_of_perihelion:         77.45645,              # °
      mean_longitude:                  252.25084,             # °
      mean_radius:                     2.4397 * (10 ** 3),    # km
      equatorial_circumference:        1.53291 * (10 ** 4),   # km
      volume:                          6.08272 * (10 ** 10),  # km^3
      mass:                            3.3010 * (10 ** 23),   # kg
      density:                         5.427,                 # g/cm^3
      surface_area:                    7.4797 * (10 ** 7),    # km^2
      surface_gravity:                 3.7,                   # m/s^2
      escape_velocity:                 4.25 * (10 ** 3),      # m/s
      sidereal_rotation_period:        1407.5,                # hours
      minimum_surface_temperature:     -173,                  # °C
      maximum_surface_temperature:     427,                   # °C
      solar_intensity:                 9127,                  # W/m^2
      natural_satellites:              0,
      atmospheric_constituents:        []
    }
  end

  def render
    Hash[self.attributes.sort].reject{ |k| k == '_id' }
  end
end
