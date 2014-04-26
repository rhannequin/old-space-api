require_relative 'test_helper'

class RoutesTest < Test::Unit::TestCase

  def planets
    # %w(mercury venus earth mars jupiter saturn uranus neptune pluto)
    %w(mercury)
  end

  def test_it_home
    get '/'
    assert last_response.ok?
  end

  def test_it_sun
    get '/api/sun'
    assert last_response.ok?
  end

  def test_it_sun_now
    get '/api/sun/now'
    assert last_response.ok?
  end

  def test_it_moon
    get '/api/moon'
    assert last_response.ok?
  end

  def test_it_moon_now
    get '/api/moon/now'
    assert last_response.ok?
  end

  def test_it_planets
    planets.each do |planet|
      get "/api/planets/#{planet}"
      assert last_response.ok?
    end
  end

  def test_it_planets_now
    planets.each do |planet|
      get "/api/planets/#{planet}/now"
      assert last_response.ok?
    end
  end

  def test_it_docs
    get '/docs'
    assert last_response.ok?
  end

  def test_it_docs_sun
    get '/docs/sun'
    assert last_response.ok?
  end

  def test_it_docs_planets
    planets.each do |planet|
      get "/docs/planets/#{planet}"
      assert last_response.ok?
    end
  end

  def test_it_docs_about
    get '/docs/about'
    assert last_response.ok?
  end
end