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

  private

  def set_planets
    @planets = %i( mercury venus earth mars jupiter saturn uranus neptune pluto ).map do |planet|
      "http://solarsystem.nasa.gov/json/page-json.cfm?URLPath=planets/#{planet}/facts"
    end
  end
end
