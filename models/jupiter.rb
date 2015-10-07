class Jupiter
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
      urls:                            ['http://solarsystem.nasa.gov/planets/profile.cfm?Object=Jupiter&Display=Facts',
                                        'http://www.heavens-above.com/jupiter.aspx'],
      discovered_by:                   'Known by the Ancients',
      date_of_discovery:               'Unknown',
      semi_major_axis:                 778340820,             # km
      perihelion:                      740680000,             # km
      aphelion:                        816002000,             # km
      orbit_circumference:             4888000000,            # km
      average_orbit_velocity:          13056,                 # m/s
      mean_orbital_speed:              13.07,                 # km/s
      sidereal_orbit_period:           4332.589,              # days
      tropical_orbit_period:           4330.595,              # days
      synodic_period:                  398.88,                # days
      orbit_eccentricity:              0.04838624,
      orbit_inclination:               1.304,                 # °
      equatorial_inclination_to_orbit: 3.1,                   # °
      longitude_of_ascending_node:     100.55615,             # °
      longitude_of_perihelion:         14.75385,              # °
      mean_longitude:                  34.40438,              # °
      mean_radius:                     69911,                 # km
      equatorial_radius:               71492,                 # km
      polar_radius:                    66854,                  # km
      equatorial_circumference:        439264,                # km
      volume:                          1431280000000000,      # km^3
      mass:                            1.8981 * (10 ** 27),   # kg
      density:                         1.326,                 # g/cm^3
      surface_area:                    61419000000,           # km^2
      surface_gravity:                 24.79,                 # m/s^2
      escape_velocity:                 60200,                 # m/s
      sidereal_rotation_period:        9.92496,               # hours
      minimum_surface_temperature:     -148,                  # °C # => 'Effective Temperature'
      maximum_surface_temperature:     -148,                  # °C # => 'Effective Temperature'
      solar_intensity:                 50.5,                  # W/m^2
      natural_satellites:              63,
      atmospheric_constituents:        [{name: 'Hydrogen', notation: 'H₂'},
                                        {name: 'Helium', notation: 'He'}]
    }
  end

  def render
    Hash[self.attributes.sort].reject{ |k| k == '_id' }
  end
end
