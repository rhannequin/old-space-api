Kernel::require_relative 'Planet'

class MarsNow < Planet

  def initialize(config)
    @urls = [
      'http://www.heavens-above.com/planets.aspx',
      'http://heavens-above.com/planetsummary.aspx'
    ]
    @planet_name = 'mars'
    super config
  end

  def parse
    documents = load
    return parse_planets(documents.first).merge(parse_planet(load.last))
  end

end