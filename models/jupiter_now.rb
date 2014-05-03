Kernel::require_relative 'Planet'

class JupiterNow < Planet

  def initialize
    @urls = [
      'http://www.heavens-above.com/planets.aspx',
      'http://heavens-above.com/planetsummary.aspx'
    ]
    @planet_name = 'jupiter'
  end

  def parse
    documents = load
    return parse_planets(documents.first).merge(parse_planet(load.last))
  end

end