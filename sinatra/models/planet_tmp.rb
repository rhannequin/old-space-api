class PlanetTmp
  include Mongoid::Document

  field :slug,                        type: String
  field :name,                        type: String
  field :date_of_discovery,           type: String
  field :discovered_by,               type: String
  field :orbit_size,                  type: Float
  field :mean_orbit_velocity,         type: Float
  field :orbit_eccentricity,          type: Float
  field :equatorial_inclination,      type: Float
  field :equatorial_radius,           type: Float
  field :equatorial_circumference,    type: Float
  field :volume,                      type: Integer
  field :mass,                        type: Integer
  field :density,                     type: Float
  field :surface_area,                type: Integer
  field :surface_gravity,             type: Float
  field :escape_velocity,             type: Float
  field :sidereal_rotation_period,    type: Float
  field :minimum_surface_temperature, type: Integer
  field :maximum_surface_temperature, type: Integer
end
