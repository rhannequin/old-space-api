require 'open-uri'
require 'nokogiri'

require_relative 'test_helper'
require_relative '../init_static'

class DbPrepareTest < Test::Unit::TestCase
  def test_setup
    assert_equal true, @task.planets_uris.has_key?(:mercury)
    assert_equal true, @task.planets_uris[:mercury].kind_of?(Array)
  end

  def test_planet_mercury
    uri = 'http://solarsystem.nasa.gov/json/page-json.cfm?URLPath=planets/mercury/facts'
    body = ''
    assert_nothing_raised do
      body = open(uri).read
    end
    assert_equal false, body.empty?
    nokogiri = Nokogiri::HTML(body)
    paragraphs = nokogiri.css('p')
    private_parse_planet 'mercury', nokogiri
    private_planet_discover_date_and_people paragraphs
    private_planet_orbit_circumference paragraphs
  end

  def setup
    @task = DbPrepare.new
  end

  private

  def private_parse_planet(name, nokogiri)
    planet = @task.parse_planet(name, nokogiri)
    assert_equal true, planet.kind_of?(PlanetTmp)
    assert_equal name, planet.slug
    assert_equal name.capitalize, planet.name
  end

  def private_planet_discover_date_and_people(paragraphs)
    paragraph = paragraphs[2].inner_html
    date = @task.planet_discover_date_and_people paragraph, :date_of_discovery
    people = @task.planet_discover_date_and_people paragraph, :discovered_by
    assert_equal true, date.kind_of?(String)
    assert_equal false, date.empty?
    assert_equal true, people.kind_of?(String)
    assert_equal false, people.empty?
  end

  def private_planet_orbit_circumference(paragraphs)
    paragraph = paragraphs[4].inner_html
    orbit = @task.planet_orbit_circumference paragraph
    assert_equal true, orbit.kind_of?(Float)
    assert_equal true, orbit.between?(10**7, 10**8)
  end
end
