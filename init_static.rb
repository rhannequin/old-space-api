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
    planet.orbit_circumference = scientific_notation paragraphs[4].inner_html
    planet.mean_orbit_velocity = scientific_notation paragraphs[6].inner_html
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

  def scientific_notation(paragraph)
    str = paragraph.split('<br>')[2].split('</b>').last.split('x')
    significand = BigDecimal(str.first)
    exposant = str.last.scan(/<sup>([^<>]*)<\/sup>/).flatten.first.to_i
    (significand * (10 ** exposant)).to_f
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
