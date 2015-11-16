class Planet < ActiveRecord::Base
  include Cleanable
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates_numericality_of :orbit_size, greater_than: 0
  validates_numericality_of :mean_orbit_velocity, greater_than: 0
  validates_numericality_of :equatorial_radius, greater_than: 0
  validates_numericality_of :equatorial_circumference, greater_than: 0
  validates_numericality_of :volume, greater_than: 0, only_integer: true
  validates_numericality_of :mass, greater_than: 0, only_integer: true
  validates_numericality_of :surface_area, greater_than: 0, only_integer: true
  validates_numericality_of :escape_velocity, greater_than: 0
end
