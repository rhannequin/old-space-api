class Api::V1::Parser::Planets::ParsePlanets < Api::V1::Parser::Parser
  attr_accessor :planets

  def initialize
    set_planets
    super
  end

  def all
    ActiveRecord::Base.transaction do
      @planets.each do |planet|
      # [@planets.first].each do |planet|
        content = get_content planet
        properties = Api::V1::Parser::Planets::ParsePlanetsFromSolarsystemNasaGov.new(content[:content]).properties
        associations = properties.extract!(:associations)[:associations]
        mdl = Planet.new({ name: content[:name] }.merge(properties))
        associations.each { |k, v| mdl.public_send(k).build(v) }
        mdl.save
      end
    end
  end

  private

  def set_planets
    @planets = %i( mercury venus earth mars jupiter saturn uranus neptune pluto ).map do |planet|
      "http://solarsystem.nasa.gov/json/page-json.cfm?URLPath=planets/#{planet}/facts"
    end
  end
end
