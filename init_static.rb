require 'open-uri'
require 'nokogiri'
require 'mongoid'
require_relative 'require_models'

planets_uris = {
  mercury: %w( http://solarsystem.nasa.gov/json/page-json.cfm?URLPath=planets/mercury/facts )
}

def parse_planet(name, document)
  planet = PlanetTmp.new slug: name, name: name.capitalize
  paragraphs = document.css('p')
  planet.date_of_discovery = paragraphs[2].inner_html.split('<br>').first.split('</b>').last.strip
  puts planet.inspect
end

planets_uris.each do |planet, uris|
  uris.each do |uri|
    parse_planet planet, Nokogiri::HTML(open(uri).read)
  end
end
