# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151125220048) do

  create_table "atm_els", force: :cascade do |t|
    t.string   "name"
    t.string   "chemical_formula"
    t.integer  "atmosphereable_id"
    t.string   "atmosphereable_type"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "atm_els", ["atmosphereable_type", "atmosphereable_id"], name: "index_atm_els_on_atmosphereable_type_and_atmosphereable_id"

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "planets", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "date_of_discovery"
    t.string   "discovered_by"
    t.integer  "mean_orbit_size",                  limit: 10
    t.float    "mean_orbit_velocity"
    t.float    "orbit_eccentricity"
    t.float    "equatorial_inclination"
    t.float    "equatorial_radius"
    t.float    "equatorial_circumference"
    t.decimal  "volume"
    t.decimal  "mass"
    t.float    "density"
    t.integer  "surface_area",                     limit: 11
    t.float    "surface_gravity"
    t.integer  "escape_velocity",                  limit: 11
    t.float    "sidereal_rotation_period"
    t.integer  "minimum_surface_temperature"
    t.integer  "maximum_surface_temperature"
    t.float    "polar_radius"
    t.float    "volumetric_mean_radius"
    t.float    "ellipticity"
    t.float    "acceleration"
    t.float    "standard_gravitational_parameter"
    t.float    "bond_albedo"
    t.float    "visual_geometric_albedo"
    t.float    "visual_magnitude"
    t.float    "solar_irradiance"
    t.float    "black_body_temperature"
    t.float    "semimajor_axis"
    t.float    "sidereal_orbit_period"
    t.float    "tropical_orbit_period"
    t.float    "perihelion"
    t.float    "aphelion"
    t.float    "maximum_orbital_velocity"
    t.float    "minimum_orbital_velocity"
    t.float    "orbit_inclination"
    t.float    "length_of_day"
    t.float    "obliquity_to_orbit"
  end

  add_index "planets", ["slug"], name: "index_planets_on_slug", unique: true

end
