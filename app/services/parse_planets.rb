class ParsePlanets < Parser
  attr_accessor :planets

  def initialize(config)
    @planets = config[:planets]
    super(config)
  end

  def all
    # @planets.each do |planet|
    #   content = get_content planet
        content = get_content(@planets.first)
    #   mdl = parse_planet(planet[:name, get_content(planets[:uri]))
        mdl = parse_planet content[:name], content[:content]
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
