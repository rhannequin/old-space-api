require 'open-uri'
require 'nokogiri'
require 'mongoid'
require_relative 'require_models'

planets_uris = {
  mercury: %w( http://solarsystem.nasa.gov/json/page-json.cfm?URLPath=planets/mercury/facts )
}

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

def planet_orbit_circumference(paragraph)
  str = paragraph.split('<br>')[2].split('</b>').last.split('x')
  significand = str.first.to_f
  exposant = str.last.scan(/<sup>([^<>]*)<\/sup>/).flatten.first.to_i
  significand * (10 ** exposant)
end

def parse_planet(name, document)
  planet = PlanetTmp.new slug: name, name: name.capitalize
  paragraphs = document.css('p')
  tmp = paragraphs[2].inner_html
  planet.date_of_discovery = planet_discover_date_and_people tmp, :date_of_discovery
  planet.discovered_by = planet_discover_date_and_people tmp, :discovered_by
  planet.orbit_circumference = planet_orbit_circumference paragraphs[4].inner_html
  puts planet.inspect
end

planets_uris.each do |planet, uris|
  uris.each do |uri|
    parse_planet planet, Nokogiri::HTML(open(uri).read)
  end
end
