class Planet < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_many :atm_els, as: :atmosphereable

  validates_numericality_of :mean_orbit_size, greater_than: 0
  validates_numericality_of :mean_orbital_velocity, greater_than: 0
  validates_numericality_of :orbital_eccentricity, greater_than: 0
  validates_numericality_of :equatorial_radius, greater_than: 0
  validates_numericality_of :equatorial_circumference, greater_than: 0
  validates_numericality_of :volume, greater_than: 0
  validates_numericality_of :mass, greater_than: 0
  validates_numericality_of :density, greater_than: 0
  validates_numericality_of :surface_area, greater_than: 0, only_integer: true
  validates_numericality_of :surface_gravity, greater_than: 0
  validates_numericality_of :escape_velocity, greater_than: 0
  validates_numericality_of :minimum_surface_temperature, greater_than: 0, only_integer: true
  validates_numericality_of :maximum_surface_temperature, greater_than: 0, only_integer: true
end
