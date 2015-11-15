class AddAttributesToPlanets < ActiveRecord::Migration
  def change
    add_column :planets, :discovered_by, :string
    add_column :planets, :orbit_size, :float
    add_column :planets, :mean_orbit_velocity, :float
    add_column :planets, :orbit_eccentricity, :float
    add_column :planets, :equatorial_inclination, :float
    add_column :planets, :equatorial_radius, :float
    add_column :planets, :equatorial_circumference, :float
    add_column :planets, :volume, :integer
    add_column :planets, :mass, :integer
    add_column :planets, :density, :float
    add_column :planets, :surface_area, :integer
    add_column :planets, :surface_gravity, :float
    add_column :planets, :escape_velocity, :float
    add_column :planets, :sidereal_rotation_period, :float
    add_column :planets, :minimum_surface_temperature, :integer
    add_column :planets, :maximum_surface_temperature, :integer
  end
end
