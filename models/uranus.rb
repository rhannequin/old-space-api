class Uranus
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
      discovered_by:                   'William Herschel',
      date_of_discovery:               '1781-03-13',
      semi_major_axis:                 2870658200,            # km
      perihelion:                      2735000000,            # km
      aphelion:                        3006320000,            # km
      orbit_circumference:             18030000000,           # km
      average_orbit_velocity:          6799.1,                # m/s
      mean_orbital_speed:              6.81,                  # km/s
      sidereal_orbit_period:           30685.4,               # days
      tropical_orbit_period:           30588.74,              # days
      synodic_period:                  369.66,                # days
      orbit_eccentricity:              0.04725744,
      orbit_inclination:               0.77,                  # °
      equatorial_inclination_to_orbit: 97.8,                  # °
      longitude_of_ascending_node:     74.22988,              # °
      longitude_of_perihelion:         170.96424,             # °
      mean_longitude:                  313.23218,             # °
      mean_radius:                     25362,                 # km
      equatorial_radius:               25559,                 # km
      polar_radius:                    24973,                 # km
      equatorial_circumference:        159354,                # km
      volume:                          68334400000000,        # km^3
      mass:                            8.6810 * (10 ** 25),   # kg
      density:                         1.270,                 # g/cm^3
      surface_area:                    8083100000,            # km^2
      surface_gravity:                 8.87,                  # m/s^2
      escape_velocity:                 21380,                 # m/s
      sidereal_rotation_period:        -17.23992,             # hours
      minimum_surface_temperature:     -216,                  # °C # => 'Effective Temperature'
      maximum_surface_temperature:     -216,                  # °C # => 'Effective Temperature'
      solar_intensity:                 3.71,                  # W/m^2
      natural_satellites:              27,
      atmospheric_constituents:        %w(H₂ He CH₄)
    }
  end

  def render
    Hash[self.attributes.sort].reject{ |k| k == '_id' }
  end
end
