class Mars
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
      urls:                            ['http://solarsystem.nasa.gov/planets/profile.cfm?Object=Mars&Display=Facts',
                                        'http://www.heavens-above.com/mars.aspx'],
      discovered_by:                   'Known by the Ancients',
      date_of_discovery:               'Unknown',
      semi_major_axis:                 227943820,             # km
      perihelion:                      206655000,             # km
      aphelion:                        249232000,             # km
      orbit_circumference:             1429000000,            # km
      average_orbit_velocity:          24077,                 # m/s
      mean_orbital_speed:              24.13,                 # km/s
      sidereal_orbit_period:           686.980,               # days
      tropical_orbit_period:           686.973,               # days
      synodic_period:                  779.94,                # days
      orbit_eccentricity:              0.0933941,
      orbit_inclination:               1.85,                  # °
      equatorial_inclination_to_orbit: 25.2,                  # °
      longitude_of_ascending_node:     49.57854,              # °
      longitude_of_perihelion:         336.04084,             # °
      mean_longitude:                  355.45332,             # °
      mean_radius:                     3389.5,                # km
      equatorial_radius:               3397,                  # km
      polar_radius:                    3375,                  # km
      equatorial_circumference:        21296.9,               # km
      volume:                          163116000000,          # km^3
      mass:                            6.4169 * (10 ** 24),   # kg
      density:                         3.934,                 # g/cm^3
      surface_area:                    144370000,             # km^2
      surface_gravity:                 3.71,                  # m/s^2
      escape_velocity:                 5030,                  # m/s
      sidereal_rotation_period:        24.623,                # hours
      minimum_surface_temperature:     -173,                  # °C
      maximum_surface_temperature:     427,                   # °C
      solar_intensity:                 589.2,                 # W/m^2
      natural_satellites:              2,
      atmospheric_constituents:        []
    }
  end

  def render
    Hash[self.attributes.sort].reject{ |k| k == '_id' }
  end
end
