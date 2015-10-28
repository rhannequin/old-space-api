require_relative 'test_helper'

class PlanetsTest < Test::Unit::TestCase
  def setup
    PlanetTmp.create name: 'Mercury'
  end

  def test_it_planets
    get '/api/v2/planets/mercury'
    assert last_response.ok?
    expected = { 'data' => { 'name' => 'Mercury' }, 'code' => 200 }
    assert_equal(expected, JSON.parse(last_response.body))
  end

  def test_it_planets_doesnt_exist
    get '/api/v2/planets/zuzu'
    assert_equal 404, last_response.status
  end
end
