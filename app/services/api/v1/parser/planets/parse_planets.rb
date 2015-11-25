SNG = Api::V1::Parser::Planets::ParsePlanetsFromSolarsystemNasaGov
NGNG = Api::V1::Parser::Planets::ParsePlanetsFromNssdcGsfcNasaGov

class Api::V1::Parser::Planets::ParsePlanets < Api::V1::Parser::Parser
  attr_accessor :planets

  def initialize
    set_planets
    super
  end

  # TODO
  # => Get real planet name (data somewhere? Capitalize from loop?)
  # => Change attributes types when necessary from float to integer
  # => Check consistency in attrubute names (e.g. "orbit"/"orbital")
  # => Clean method `all` (split it?)
  # => Clean parsing globally: comments, simplest methods possible
  # => Check parsing efficienty
  # => Handle JSON prettify parameter and use it by default
  # => Handle XML responses
  # => Check if any other attribute can be added to the Planet model
  # => Handle atm_els proportions
  # => Documentation on wiki for the new attributes

  def all
    ActiveRecord::Base.transaction do
      # @planets.each do |planet|
      [@planets.first].each do |planet|
        properties = sng_properties(planet)
                     .deep_merge(ngng_properties(planet))
        associations = properties.extract!(:associations)[:associations]
        mdl = Planet.new({ name: planet }.merge(properties))
        associations.each { |k, v| mdl.public_send(k).build(v) }
        mdl.save
        puts " % Created Planet #{mdl.name} successfully"
      end
    end
  end

  def sng_properties(planet)
    content = get_content SNG.uri(planet)
    parser = SNG.new content
    parser.properties
  end

  def ngng_properties(planet)
    content = get_content NGNG.uri(planet)
    parser = NGNG.new content
    parser.properties
  end

  private

  def set_planets
    @planets = %w( mercury venus earth mars jupiter saturn uranus neptune pluto )
  end
end
