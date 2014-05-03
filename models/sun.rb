class Sun
  include Mongoid::Document

  field :url                             , type: String
  field :discovered_by                   , type: String
  field :date_of_discovery               , type: String
  field :equatorial_inclination_to_orbit , type: Float
  field :mean_radius                     , type: Integer
  field :equatorial_circumference        , type: Float
  field :volume                          , type: Float
  field :mass                            , type: Float
  field :density                         , type: Float
  field :surface_area                    , type: Float
  field :surface_gravity                 , type: Integer
  field :escape_velocity                 , type: Integer
  field :sidereal_rotation_period        , type: Float
  field :minimum_surface_temperature     , type: Integer
  field :maximum_surface_temperature     , type: Integer
  field :effective_temperature           , type: Integer
  field :spectral_type                   , type: Float
  field :age                             , type: Integer
  field :hydrogen                        , type: Float
  field :helium                          , type: Float
  field :synodic_period                  , type: Float
  field :rotation_period_at_equator      , type: Float
  field :rotation_period_at_poles        , type: Integer
  field :velocity_relative_to_near_stars , type: Float
  field :mean_distance_to_earth          , type: Float

  def self.prepare
    self.delete_all
    self.create initial_values
  end

  def self.initial_values
    {
      url:                             'http://solarsystem.nasa.gov/planets/profile.cfm?Object=Sun&Display=Facts&System=Metric',
      discovered_by:                   'Known by the Ancients',
      date_of_discovery:               'Unknown',
      equatorial_inclination_to_orbit: 7.25,                            # °
      mean_radius:                     695508,                          # km
      equatorial_circumference:        437000.56,                       # km
      volume:                          1409272569059860000,             # km^3
      mass:                            1989100000000000000000000000000, # kg
      density:                         1.409,                           # g/cm^3 # /!\
      surface_area:                    6078747774547,                   # km^2
      surface_gravity:                 274,                             # m/s^2
      escape_velocity:                 617700,                          # m/s /!\
      sidereal_rotation_period:        609.12,                          # hour
      minimum_surface_temperature:     5500,                            # °C
      maximum_surface_temperature:     5500,                            # °C
      effective_temperature:           5777,                            # K
      spectral_type:                   3.83 * (10 ** 33),               # ergs/sec
      age:                             4600000000,                      # year
      hydrogen:                        92.1,                            # %
      hydrogen:                        7.8,                             # %
      synodic_period:                  27.2753,                         # day
      rotation_period_at_equator:      26.8,                            # day
      rotation_period_at_poles:        36,                              # days
      velocity_relative_to_near_stars: 19.7,                            # km/s
      mean_distance_to_earth:          149600000                        # km
    }
  end

  def render
    Hash[self.attributes.sort].reject{ |k| k == '_id' }
  end
end
