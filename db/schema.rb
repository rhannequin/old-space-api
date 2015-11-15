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

ActiveRecord::Schema.define(version: 20151115211143) do

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
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "date_of_discovery"
    t.string   "discovered_by"
    t.float    "orbit_size"
    t.float    "mean_orbit_velocity"
    t.float    "orbit_eccentricity"
    t.float    "equatorial_inclination"
    t.float    "equatorial_radius"
    t.float    "equatorial_circumference"
    t.integer  "volume"
    t.integer  "mass"
    t.float    "density"
    t.integer  "surface_area"
    t.float    "surface_gravity"
    t.float    "escape_velocity"
    t.float    "sidereal_rotation_period"
    t.integer  "minimum_surface_temperature"
    t.integer  "maximum_surface_temperature"
  end

  add_index "planets", ["slug"], name: "index_planets_on_slug", unique: true

end
