SNG = Api::V1::Parser::Planets::ParsePlanetsFromSolarsystemNasaGov
NGNG = Api::V1::Parser::Planets::ParsePlanetsFromNssdcGsfcNasaGov

class Api::V1::Parser::Planets::ParsePlanets < Api::V1::Parser::Parser
  attr_accessor :planets

  def initialize
    set_planets
    super
  end

  # TODO
  # => Clean parsing globally: comments, simplest methods possible
  # => Check parsing efficienty
  # => Handle XML responses
  # => Check if any other attribute can be added to the Planet model
  # => Handle atm_els proportions
  # => Documentation on wiki for the new attributes

  def all
    properties = get_properties
    create_models(properties)
  end

  def get_properties
    puts ' % Start loading remote data ...'
    properties = []
    # @planets.each do |planet|
    [@planets.first].each do |planet|
      properties << planet_properties(planet)
    end
    puts ' % ... Remote data loaded'
    properties
  end

  def planet_properties(planet)
    { name: planet.capitalize }
      .merge(sng_properties(planet))
      .deep_merge(ngng_properties(planet))
  end

  def create_models(models)
    ActiveRecord::Base.transaction do
      models.each do |properties|
        mdl = create_model(properties)
        mdl.save
        puts " % Created Planet #{mdl.name} successfully"
      end
    end
  end

  def create_model(properties)
    associations = properties.extract!(:associations)[:associations]
    mdl = Planet.new(properties)
    associations.each { |k, v| mdl.public_send(k).build(v) }
    mdl
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
