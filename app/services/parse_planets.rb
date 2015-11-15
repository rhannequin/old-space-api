require 'bigdecimal'

class ParsePlanets < Parser
  attr_accessor :planets

  def initialize
    set_planets
    super
  end

  def all
    # @planets.each do |planet|
    [@planets.first].each do |planet|
      content = get_content planet
      mdl = parse_planet content[:name], content[:content]
      puts mdl.inspect
    end
  end

  def parse_planet(name, document)
    planet = Planet.new name: name
    paragraphs = document.css('p')
    tmp = paragraphs[1].inner_html
    planet.date_of_discovery = discover_date_and_people tmp, :date_of_discovery
    planet.discovered_by = discover_date_and_people tmp, :discovered_by
    planet.orbit_size = scientific_notation paragraphs[3].inner_html, 2, :float
    planet.mean_orbit_velocity = scientific_notation paragraphs[5].inner_html, 2, :float
    planet.equatorial_radius = scientific_notation paragraphs[11].inner_html, 2, :float
    planet.equatorial_circumference = scientific_notation paragraphs[13].inner_html, 2, :float
    planet.volume = scientific_notation paragraphs[15].inner_html, 2, :integer
    planet.mass = scientific_notation paragraphs[17].inner_html, 1, :integer
    planet.surface_area = scientific_notation paragraphs[21].inner_html, 2, :integer
    planet.escape_velocity = scientific_notation paragraphs[27].inner_html, 2, :integer
    planet
  end

  def discover_date_and_people(paragraph, field)
    paragraph = paragraph.split('<br>')
    str = case field
    when :date_of_discovery
      paragraph.first
    when :discovered_by
      paragraph[1]
    end
    str.split('</b>').last.strip
  end

  def scientific_notation(paragraph, position, type)
    str = paragraph.split('<br>')[position].split('</b>').last.split('x')
    significand = BigDecimal(str.first)
    exposant = str.last.scan(/<sup>([^<>]*)<\/sup>/).flatten.first.to_i
    bigdecimal_to_type(significand * (10 ** exposant), type)
  end

  private

  def set_planets
    @planets = %i( mercury venus earth mars jupiter saturn uranus neptune pluto ).map do |planet|
      "http://solarsystem.nasa.gov/json/page-json.cfm?URLPath=planets/#{planet}/facts"
    end
  end

  def bigdecimal_to_type(number, type)
    method = case type
    when :integer then :i
    when :float then :f
    else :f
    end
    number.send :"to_#{method}"
  end
end
