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
    assert_equal true, data.has_key?('orbit_circumference')
  end

  def test_it_has_correct_values
    get '/api/v2/planets/mercury'
    json = JSON.parse(last_response.body)['data']
    assert_equal 'mercury',               json['slug']
    assert_equal 'Mercury',               json['name']
    assert_equal 'Unknown',               json['date_of_discovery']
    assert_equal 'Known by the Ancients', json['discovered_by']
    assert_equal 57909227.to_f,           json['orbit_circumference']
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
      discovered_by: 'Known by the Ancients',
      orbit_circumference: 57909227.to_f
    })
  end
end
