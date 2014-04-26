class Venus
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
      urls:                            ['http://solarsystem.nasa.gov/planets/profile.cfm?Object=Venus&Display=Facts',
                                        'http://www.heavens-above.com/venus.aspx'],
      discovered_by:                   'Known by the Ancients',
      date_of_discovery:               'Unknown',
      semi_major_axis:                 1.08209480,            # km
      perihelion:                      107476000,             # km
      aphelion:                        108943000,             # km
      orbit_circumference:             679900000,             # km
      average_orbit_velocity:          35020,                 # m/s
      mean_orbital_speed:              35.02,                 # km/s
      sidereal_orbit_period:           224.701,               # days
      tropical_orbit_period:           224.695,               # days
      synodic_period:                  583.92,                # days
      orbit_eccentricity:              0.00677672,
      orbit_inclination:               3.39,                  # °
      equatorial_inclination_to_orbit: 177.3,                 # °
      longitude_of_ascending_node:     76.68069,              # °
      longitude_of_perihelion:         131.53298,             # °
      mean_longitude:                  181.97973,             # °
      mean_radius:                     6051.8,                # km
      equatorial_radius:               6051.8,                # km
      polar_radius:                    6051.8,                # km
      equatorial_circumference:        38024.6,               # km
      volume:                          928415000000,          # km^3
      mass:                            4.8673 * (10 ** 24),   # kg
      density:                         5.243,                 # g/cm^3
      surface_area:                    460230000,             # km^2
      surface_gravity:                 8.87,                  # m/s^2
      escape_velocity:                 10360,                 # m/s
      sidereal_rotation_period:        -5832.4 ,              # hours
      minimum_surface_temperature:     462,                   # °C
      maximum_surface_temperature:     462,                   # °C
      solar_intensity:                 2613.9,                # W/m^2
      natural_satellites:              0,
      atmospheric_constituents:        ['CO₂', 'N₂']
    }
  end

  def render
    Hash[self.attributes.sort].reject{ |k| k == '_id' }
  end
end
