class Moon
  include Mongoid::Document

  field :url                             , type: String
  field :discovered_by                   , type: String
  field :date_of_discovery               , type: String
  field :semi_major_axis                 , type: Integer
  field :mean_distance_to_earth          , type: Integer
  field :perigee                         , type: Integer
  field :apogee                          , type: Integer
  field :orbit_circumference             , type: Integer
  field :average_orbit_velocity          , type: Integer
  field :orbit_eccentricity              , type: Float
  field :orbit_incination                , type: Float
  field :equatorial_inclination_to_orbit , type: Float
  field :mean_radius                     , type: Integer
  field :equatorial_circumference        , type: Integer
  field :volume                          , type: Float
  field :mass                            , type: Float
  field :density                         , type: Float
  field :surface_area                    , type: Integer
  field :surface_gravity                 , type: Float
  field :escape_velocity                 , type: Integer
  field :sidereal_rotation_period        , type: Float
  field :minimum_surface_temperature     , type: Integer
  field :maximum_surface_temperature     , type: Integer

  def self.prepare
    self.delete_all
    self.create initial_values
  end

  def self.initial_values
    {
      url:                             'http://solarsystem.nasa.gov/planets/profile.cfm?Object=Moon&Display=Facts&System=Metric',
      discovered_by:                   'Known by the Ancients',
      date_of_discovery:               'Unknown',
      semi_major_axis:                 3.844 * (10 ** 5),    # km
      mean_distance_to_earth:          3.844 * (10 ** 5),    # km
      perigee:                         3.631 * (10 ** 5),    # km
      apogee:                          4.057 * (10 ** 5),    # km
      orbit_circumference:             2.413 * (10 ** 6),    # km
      average_orbit_velocity:          1022,                 # m/s
      orbit_eccentricity:              0.0554,
      orbit_incination:                5.16,                 # °
      equatorial_inclination_to_orbit: 6.68,                 # °
      mean_radius:                     1.738 * (10 ** 3),    # km
      equatorial_circumference:        1.0917 * (10 ** 4),   # km
      volume:                          2.197 * (10 ** 10),   # km^3
      mass:                            7.3477 * (10 ** 22),  # kg
      density:                         3.344,                # g/cm^3 # /!\
      surface_area:                    3.793669 * (10 ** 7), # km^2
      surface_gravity:                 1.624,                # m/s^2
      escape_velocity:                 2376,                 # m/s /!\
      sidereal_rotation_period:        655.73,               # hour
      minimum_surface_temperature:     -233,                 # °C
      maximum_surface_temperature:     123                   # °C
    }
  end

  def render
    Hash[self.attributes.sort].reject{ |k| k == '_id' }
  end
end
