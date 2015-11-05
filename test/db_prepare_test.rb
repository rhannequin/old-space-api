require 'open-uri'
require 'nokogiri'
require 'bigdecimal'

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
      body = open(uri, @task.proxy).read
    end
    assert_equal false, body.empty?
    nokogiri = Nokogiri::HTML(body)
    paragraphs = nokogiri.css('p')
    private_parse_planet 'mercury', nokogiri
    private_planet_discover_date_and_people paragraphs
    private_first_value_to_f
    private_scientific_notation
    private_bigdecimal_to_type
    private_metric_value_to_f
  end

  def setup
    @task = DbPrepare.new(get_config)
  end

  private

  def private_parse_planet(name, nokogiri)
    planet = @task.parse_planet(name, nokogiri)
    assert_equal true, planet.kind_of?(PlanetTmp)
    assert_equal name, planet.slug
    assert_equal name.capitalize, planet.name
    assert_equal true, planet.orbit_size.kind_of?(Float) && planet.orbit_size.between?(10**7, 10**8)
    assert_equal true, planet.mean_orbit_velocity.kind_of?(Float) && planet.mean_orbit_velocity.between?(10**4, 10**5)
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

  def private_scientific_notation
    value1 = @task.scientific_notation " <b></b><br><b></b><br><b></b> 1.2345 x 10<sup>4</sup> m/s<br><b></b><br> ", 2, :float
    value2 = @task.scientific_notation " <b></b><br><b></b><br><b></b> 1.23456 x 10<sup>3</sup> m/s<br><b></b><br> ", 2, :float
    value3 = @task.scientific_notation " <b></b><br><b></b><br><b></b> 0.1234 x 10<sup>8</sup> m/s<br><b></b><br> ", 2, :float
    value4 = @task.scientific_notation " <b></b><br><b></b><br><b></b> 0.1234 x 10<sup>8</sup> m/s<br><b></b><br> ", 2, :integer
    value5 = @task.scientific_notation " <b></b><br><b></b> 1.2345 x 10<sup>5</sup> kg<br><b></b><br> ", 1, :float
    assert_equal(true, value1.kind_of?(Float))
    assert_equal(true, value1.eql?(12345.0))
    assert_equal(true, value2.eql?(1234.56))
    assert_equal(true, value3.eql?(12340000.0))
    assert_equal(true, value4.eql?(12340000))
    assert_equal(true, value5.eql?(123450.0))
  end

  def private_bigdecimal_to_type
    value1 = @task.bigdecimal_to_type BigDecimal('10'), :integer
    value2 = @task.bigdecimal_to_type BigDecimal('10'), :float
    assert_equal(true, value1.kind_of?(Integer))
    assert_equal(true, value2.kind_of?(Float))
    assert_equal(true, value1.eql?(10))
    assert_equal(true, value2.eql?(10.0))
  end

  def private_first_value_to_f
    value1 = @task.first_value_to_f " 0.123456<br><b></b><br> "
    value2 = @task.first_value_to_f " 1.2 degrees<br><b></b><br> "
    value3 = @task.first_value_to_f " 0<br><b></b><br> "
    assert_equal(true, value1.kind_of?(Float))
    assert_equal(true, value1.eql?(0.123456))
    assert_equal(true, value2.eql?(1.2))
    assert_equal(true, value3.eql?(0.0))
  end

  def private_metric_value_to_f
    value1 = @task.metric_value_to_f " <b>Metric:</b> 1.2 m/s<sup>2</sup><br><b></b><br><b><br> "
    assert_equal(true, value1.kind_of?(Float))
    assert_equal(true, value1.eql?(1.2))
  end
end
