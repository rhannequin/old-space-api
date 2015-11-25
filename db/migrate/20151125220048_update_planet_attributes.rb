class UpdatePlanetAttributes < ActiveRecord::Migration
  def change
    rename_column :planets, :orbit_size, :mean_orbit_size
    add_column :planets, :polar_radius, :float
    add_column :planets, :volumetric_mean_radius, :float
    add_column :planets, :ellipticity, :float
    add_column :planets, :acceleration, :float
    add_column :planets, :standard_gravitational_parameter, :float
    add_column :planets, :bond_albedo, :float
    add_column :planets, :visual_geometric_albedo, :float
    add_column :planets, :visual_magnitude, :float
    add_column :planets, :solar_irradiance, :float
    add_column :planets, :black_body_temperature, :float
    add_column :planets, :semimajor_axis, :float
    add_column :planets, :sidereal_orbit_period, :float
    add_column :planets, :tropical_orbit_period, :float
    add_column :planets, :perihelion, :float
    add_column :planets, :aphelion, :float
    add_column :planets, :maximum_orbital_velocity, :float
    add_column :planets, :minimum_orbital_velocity, :float
    add_column :planets, :orbit_inclination, :float
    add_column :planets, :length_of_day, :float
    add_column :planets, :obliquity_to_orbit, :float
  end
end
