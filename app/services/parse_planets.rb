class ParsePlanets < Parser
  attr_accessor :planets

  def initialize(config)
    @planets = config[:planets]
    super(config)
  end

  def all
    # @planets.each do |planet|
    #   mdl = parse_planet(planet[:name, get_content(planets[:uri]))
        mdl = parse_planet(@planets.first[:name], get_content(@planets.first[:uri]))
        puts mdl.inspect
    # end
  end

  def parse_planet(name, document)
    planet = Planet.new name: name
    paragraphs = document.css('p')
    tmp = paragraphs[2].inner_html
    planet
  end
end
