class Neptune
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
      urls:                            ['http://solarsystem.nasa.gov/planets/profile.cfm?Object=Neptune&Display=Facts',
                                        'http://www.heavens-above.com/neptune.aspx'],
      discovered_by:                   'Urbain Le Verrier, John Couch Adams, Johann Galle',
      date_of_discovery:               '1846-09-23',
      # semi_major_axis:                 4495060000,            # km
      # perihelion:                      4444450000,            # km
      # aphelion:                        4545670000,            # km
      # orbit_circumference:             18030000000,           # km
      average_orbit_velocity:          5434.9,                # m/s
      # mean_orbital_speed:              5.43,                  # km/s
      # sidereal_orbit_period:           30685.4,               # days
      # tropical_orbit_period:           30588.74,              # days
      # synodic_period:                  369.66,                # days
      orbit_eccentricity:              0.00859048,
      # orbit_inclination:               0.77,                  # °
      equatorial_inclination_to_orbit: 28.3,                  # °
      # longitude_of_ascending_node:     74.22988,              # °
      # longitude_of_perihelion:         170.96424,             # °
      # mean_longitude:                  313.23218,             # °
      # mean_radius:                     25362,                 # km
      equatorial_radius:               24622,                 # km
      # polar_radius:                    24973,                 # km
      equatorial_circumference:        154705,                # km
      volume:                          62525700000000,        # km^3
      mass:                            1.0241 * (10 ** 26),   # kg
      density:                         1.638,                 # g/cm^3
      surface_area:                    7618300000,            # km^2
      surface_gravity:                 11.15,                 # m/s^2
      escape_velocity:                 23560,                 # m/s
      sidereal_rotation_period:        16.11,                 # hours
      minimum_surface_temperature:     -214,                  # °C # => 'Effective Temperature'
      maximum_surface_temperature:     -214,                  # °C # => 'Effective Temperature'
      # solar_intensity:                 3.71,                  # W/m^2
      # natural_satellites:              27,
      atmospheric_constituents:        [{name: 'Hydrogen', notation: 'H₂'},
                                        {name: 'Helium', notation: 'He'},
                                        {name: 'Methane', notation: 'CH₄'}]
    }
  end

  def render
    Hash[self.attributes.sort].reject{ |k| k == '_id' }
  end
end
