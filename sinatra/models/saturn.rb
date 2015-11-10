class Saturn
  include Mongoid::Document

  field :urls                            , type: Array
  field :discovered_by                   , type: String
  field :date_of_discovery               , type: String
  field :semi_major_axis                 , type: Float
  field :perihelion                      , type: Float
  field :aphelion                        , type: Float
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
  field :equatorial_radius               , type: Float
  field :polar_radius                    , type: Float
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
      urls:                            ['http://solarsystem.nasa.gov/planets/profile.cfm?Object=Saturn&Display=Facts',
                                        'http://www.heavens-above.com/saturn.aspx'],
      discovered_by:                   'Known by the Ancients',
      date_of_discovery:               'Unknown',
      semi_major_axis:                 1426666400,            # km
      perihelion:                      1349820000,            # km
      aphelion:                        1503510000,            # km
      orbit_circumference:             8958000000,            # km
      average_orbit_velocity:          9639.1,                # m/s
      mean_orbital_speed:              9.69,                  # km/s
      sidereal_orbit_period:           10759.22,              # days
      tropical_orbit_period:           10746.94,              # days
      synodic_period:                  378.09,                # days
      orbit_eccentricity:              0.05386179,
      orbit_inclination:               2.49,                  # °
      equatorial_inclination_to_orbit: 26.7,                  # °
      longitude_of_ascending_node:     113.71504,             # °
      longitude_of_perihelion:         92.43194,              # °
      mean_longitude:                  49.94432,              # °
      mean_radius:                     58232,                 # km
      equatorial_radius:               60268,                 # km
      polar_radius:                    54364,                  # km
      equatorial_circumference:        365882,                # km
      volume:                          827130000000000,       # km^3
      mass:                            5.6832 * (10 ** 26),   # kg
      density:                         0.687,                 # g/cm^3
      surface_area:                    42612000000,           # km^2
      surface_gravity:                 10.4,                  # m/s^2
      escape_velocity:                 36090,                 # m/s
      sidereal_rotation_period:        10.656,                # hours
      minimum_surface_temperature:     -178,                  # °C # => 'Effective Temperature'
      maximum_surface_temperature:     -178,                  # °C # => 'Effective Temperature'
      solar_intensity:                 14.90,                 # W/m^2
      natural_satellites:              47,
      atmospheric_constituents:        [{name: 'Hydrogen', notation: 'H₂'},
                                        {name: 'Helium', notation: 'He'}]
    }
  end

  def render
    Hash[self.attributes.sort].reject{ |k| k == '_id' }
  end
end
