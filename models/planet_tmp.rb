class PlanetTmp
  include Mongoid::Document

  field :slug,                   type: String
  field :name,                   type: String
  field :date_of_discovery,      type: String
  field :discovered_by,          type: String
  field :orbit_size,             type: Float
  field :mean_orbit_velocity,    type: Float
  field :orbit_eccentricity,     type: Float
  field :equatorial_inclination, type: Float
end
