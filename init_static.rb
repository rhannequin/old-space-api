require 'open-uri'
require 'nokogiri'
require 'mongoid'
require 'bigdecimal'
require_relative 'require_models'

class DbPrepare
  attr_accessor :proxy
  attr_accessor :planets_uris

  def initialize(config)
    setup config
  end

  def start
    puts 'About to launch initialization of static data...'
    parse_planets
  end

  def parse_planets
    puts '[Planet] Starts planet parsing'
    @planets_uris.each do |planet, uris|
      uris.each do |uri|
        puts "  [Planet][#{planet}] Parsing #{uri}"
        parse_planet planet, Nokogiri::HTML(open(uri, @proxy).read)
      end
    end
    puts '[Planet] End of planet parsing'
  end

  def parse_planet(name, document)
    planet = PlanetTmp.new slug: name, name: name.capitalize
    paragraphs = document.css('p')
    tmp = paragraphs[2].inner_html
    planet.date_of_discovery = planet_discover_date_and_people tmp, :date_of_discovery
    planet.discovered_by = planet_discover_date_and_people tmp, :discovered_by
    planet.orbit_size = scientific_notation paragraphs[4].inner_html, 2, :float
    planet.mean_orbit_velocity = scientific_notation paragraphs[6].inner_html, 2, :float
    planet.orbit_eccentricity = first_value_to_f paragraphs[8].inner_html
    planet.equatorial_inclination = first_value_to_f paragraphs[10].inner_html
    planet.equatorial_radius = scientific_notation paragraphs[12].inner_html, 2, :float
    planet.equatorial_circumference = scientific_notation paragraphs[14].inner_html, 2, :float
    planet.volume = scientific_notation paragraphs[16].inner_html, 2, :integer
    planet.mass = scientific_notation paragraphs[18].inner_html, 1, :integer
    planet.density = planet_density paragraphs[20].inner_html
    planet.surface_area = scientific_notation paragraphs[22].inner_html, 2, :integer
    puts planet.inspect
    planet
  end

  def planet_discover_date_and_people(paragraph, field)
    paragraph = paragraph.split('<br>')
    str = case field
    when :date_of_discovery
      paragraph.first
    when :discovered_by
      paragraph[1]
    end
    str.split('</b>').last.strip
  end

  def planet_density(paragraph)
    paragraph.split('<br>').first.split('</b>').last.to_f
  end

  def scientific_notation(paragraph, emplacement, type)
    str = paragraph.split('<br>')[emplacement].split('</b>').last.split('x')
    significand = BigDecimal(str.first)
    exposant = str.last.scan(/<sup>([^<>]*)<\/sup>/).flatten.first.to_i
    bigdecimal_to_type(significand * (10 ** exposant), type)
  end

  def bigdecimal_to_type(number, type)
    method = case type
    when :integer then :i
    when :float then :f
    else :f
    end
    number.send :"to_#{method}"
  end

  def first_value_to_f(paragraph)
    paragraph.split('<br>').first.to_f
  end

  def setup(config)
    @planets_uris = {
      mercury: %w( http://solarsystem.nasa.gov/json/page-json.cfm?URLPath=planets/mercury/facts )
    }
    @proxy = config['proxy_use'] ? {
      proxy_http_basic_authentication: [
        "#{config['proxy_url']}:#{config['proxy_port']}",
        config['proxy_username'],
        config['proxy_password']
      ]
    } : {}
  end
end
