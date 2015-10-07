class Earth
  include Mongoid::Document

  field :urls                            , type: Array
  field :discovered_by                   , type: String
  field :date_of_discovery               , type: String
  # field :semi_major_axis                 , type: Float
  # field :perihelion                      , type: Float
  # field :aphelion                        , type: Float
  # field :orbit_circumference             , type: Float
  field :average_orbit_velocity          , type: Float
  # field :mean_orbital_speed              , type: Float
  # field :sidereal_orbit_period           , type: Float
  # field :tropical_orbit_period           , type: Float
  # field :synodic_period                  , type: Float
  field :orbit_eccentricity              , type: Float
  # field :orbit_inclination               , type: Float
  field :equatorial_inclination_to_orbit , type: Float
  # field :longitude_of_ascending_node     , type: Float
  # field :longitude_of_perihelion         , type: Float
  # field :mean_longitude                  , type: Float
  # field :mean_radius                     , type: Float
  field :equatorial_radius               , type: Float
  # field :polar_radius                    , type: Float
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
  # field :solar_intensity                 , type: Float
  # field :natural_satellites              , type: Integer
  field :atmospheric_constituents        , type: Array

  def self.prepare
    self.delete_all
    self.create initial_values
  end

  def self.initial_values
    {
      urls:                            ['http://solarsystem.nasa.gov/planets/profile.cfm?Object=Earth&Display=Facts',
                                        'http://www.heavens-above.com/earth.aspx'],
      discovered_by:                   '',
      date_of_discovery:               '',
      # semi_major_axis:                 4495060000,            # km
      # perihelion:                      4444450000,            # km
      # aphelion:                        4545670000,            # km
      # orbit_circumference:             18030000000,           # km
      average_orbit_velocity:          29783,                   # m/s
      # mean_orbital_speed:              5.43,                  # km/s
      # sidereal_orbit_period:           30685.4,               # days
      # tropical_orbit_period:           30588.74,              # days
      # synodic_period:                  369.66,                # days
      orbit_eccentricity:              0.01671123,
      # orbit_inclination:               0.77,                  # °
      equatorial_inclination_to_orbit: 23.4393,                 # °
      # longitude_of_ascending_node:     74.22988,              # °
      # longitude_of_perihelion:         170.96424,             # °
      # mean_longitude:                  313.23218,             # °
      # mean_radius:                     25362,                 # km
      equatorial_radius:               6371,                  # km
      # polar_radius:                    24973,                 # km
      equatorial_circumference:        40030.2,               # km
      volume:                          1083210000000,         # km^3
      mass:                            5.9722 * (10 ** 24),   # kg
      density:                         5.513,                 # g/cm^3
      surface_area:                    510060000,             # km^2
      surface_gravity:                 9.80665,               # m/s^2
      escape_velocity:                 11190,                  # m/s
      sidereal_rotation_period:        23.934,            # hours
      minimum_surface_temperature:     -88,                  # °C
      maximum_surface_temperature:     -58,                  # °C
      # solar_intensity:                 3.71,                  # W/m^2
      # natural_satellites:              27,
      atmospheric_constituents:        [{name: 'Nitrogen', notation: 'N₂'},
                                        {name: 'Oxygen', notation: 'O'}]
    }
  end

  def render
    Hash[self.attributes.sort].reject{ |k| k == '_id' }
  end
end
