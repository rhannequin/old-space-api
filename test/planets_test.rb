require_relative 'test_helper'

class PlanetsTest < Test::Unit::TestCase
  def test_it_responses_ok
    get '/api/v2/planets/mercury'
    assert last_response.ok?
  end

  def test_it_has_correct_keys
    get '/api/v2/planets/mercury'
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
  end

  def test_it_has_correct_types
    get '/api/v2/planets/mercury'
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
  end

  def test_it_planets_doesnt_exist
    get '/api/v2/planets/zuzu'
    assert_equal 404, last_response.status
  end

  def setup
    PlanetTmp.delete_all
    PlanetTmp.create({
      slug: 'mercury',
      name: 'Mercury',
      date_of_discovery: 'Unknown',
      discovered_by: 'The Doctor',
      orbit_size: 1.to_f,
      mean_orbit_velocity: 1.to_f,
      orbit_eccentricity: 1.to_f,
      equatorial_inclination: 1.to_f,
      equatorial_radius: 1.to_f,
      equatorial_circumference: 1.to_f,
      volume: 1
    })
  end
end
