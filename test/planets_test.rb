require_relative 'test_helper'

class PlanetsTest < Test::Unit::TestCase
  attr_accessor :planets

  def test_it_responses_ok
    @planets.each do |planet|
      private_test_it_responses_ok planet
    end
  end

  def test_it_has_correct_keys
    @planets.each do |planet|
      private_test_it_has_correct_keys planet
    end
  end

  def test_it_has_correct_types
    @planets.each do |planet|
      private_test_it_has_correct_types planet
    end
  end

  def test_it_planets_doesnt_exist
    get '/api/v2/planets/zuzu'
    assert_equal 404, last_response.status
  end

  def setup
    @planets = %w( mercury )
    PlanetTmp.delete_all
    @planets.each do |planet|
      create_planet 'mercury'
    end
  end

  private

  def private_test_it_responses_ok(planet)
    get "/api/v2/planets/#{planet}"
    assert last_response.ok?
  end

  def private_test_it_has_correct_keys(planet)
    get "/api/v2/planets/#{planet}"
    json = JSON.parse(last_response.body)
    data = json['data']
    assert_equal true, json.has_key?('data')
    assert_equal true, data.has_key?('slug')
    assert_equal true, data.has_key?('name')
    assert_equal true, data.has_key?('date_of_discovery')
    assert_equal true, data.has_key?('discovered_by')
    assert_equal true, data.has_key?('orbit_size')
    assert_equal true, data.has_key?('mean_orbit_velocity')
    assert_equal true, data.has_key?('orbit_eccentricity')
    assert_equal true, data.has_key?('equatorial_inclination')
    assert_equal true, data.has_key?('equatorial_radius')
    assert_equal true, data.has_key?('equatorial_circumference')
    assert_equal true, data.has_key?('volume')
    assert_equal true, data.has_key?('mass')
    assert_equal true, data.has_key?('density')
    assert_equal true, data.has_key?('surface_area')
    assert_equal true, data.has_key?('surface_gravity')
    assert_equal true, data.has_key?('escape_velocity')
    assert_equal true, data.has_key?('minimum_surface_temperature')
    assert_equal true, data.has_key?('maximum_surface_temperature')
  end

  def private_test_it_has_correct_types(planet)
    get "/api/v2/planets/#{planet}"
    json = JSON.parse(last_response.body)['data']
    assert_equal true, json['slug'].kind_of?(String)
    assert_equal true, json['name'].kind_of?(String)
    assert_equal true, json['date_of_discovery'].kind_of?(String)
    assert_equal true, json['discovered_by'].kind_of?(String)
    assert_equal true, json['orbit_size'].kind_of?(Float)
    assert_equal true, json['mean_orbit_velocity'].kind_of?(Float)
    assert_equal true, json['orbit_eccentricity'].kind_of?(Float)
    assert_equal true, json['equatorial_inclination'].kind_of?(Float)
    assert_equal true, json['equatorial_radius'].kind_of?(Float)
    assert_equal true, json['equatorial_circumference'].kind_of?(Float)
    assert_equal true, json['volume'].kind_of?(Integer)
    assert_equal true, json['mass'].kind_of?(Integer)
    assert_equal true, json['density'].kind_of?(Float)
    assert_equal true, json['surface_area'].kind_of?(Integer)
    assert_equal true, json['surface_gravity'].kind_of?(Float)
    assert_equal true, json['escape_velocity'].kind_of?(Float)
    assert_equal true, json['sidereal_rotation_period'].kind_of?(Float)
    assert_equal true, json['minimum_surface_temperature'].kind_of?(Integer)
    assert_equal true, json['maximum_surface_temperature'].kind_of?(Integer)
  end

  def create_planet(planet)
    PlanetTmp.create({
      slug: planet,
      name: planet.capitalize,
      date_of_discovery: 'Unknown',
      discovered_by: 'The Doctor',
      orbit_size: 1.to_f,
      mean_orbit_velocity: 1.to_f,
      orbit_eccentricity: 1.to_f,
      equatorial_inclination: 1.to_f,
      equatorial_radius: 1.to_f,
      equatorial_circumference: 1.to_f,
      volume: 1,
      mass: 1,
      density: 1.0,
      surface_area: 1,
      surface_gravity: 1.0,
      escape_velocity: 1.0,
      sidereal_rotation_period: 1.0,
      minimum_surface_temperature: 1,
      maximum_surface_temperature: 1
    })
  end
end
