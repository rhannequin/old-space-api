class ParsePlanets < Parser
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
        mdl = parse_planet content[:name], content[:content]
        mdl.save
      end
    end
  end

  def parse_planet(name, document)
    planet = Planet.new name: name
    paragraphs = document.css('p')
    tmp = paragraphs[1].inner_html
    planet.date_of_discovery = discover_date_and_people tmp, :date_of_discovery
    planet.discovered_by = discover_date_and_people tmp, :discovered_by
    planet.orbit_size = scientific_notation paragraphs[3].inner_html, 2, :integer
    planet.mean_orbit_velocity = scientific_notation paragraphs[5].inner_html, 2, :float
    planet.orbit_eccentricity = precise_value_to_f paragraphs[7].inner_html, 0
    planet.equatorial_inclination = precise_value_to_f paragraphs[9].inner_html, 0
    planet.equatorial_radius = scientific_notation paragraphs[11].inner_html, 2, :float
    planet.equatorial_circumference = scientific_notation paragraphs[13].inner_html, 2, :float
    planet.volume = scientific_notation paragraphs[15].inner_html, 2, :integer
    planet.mass = scientific_notation paragraphs[17].inner_html, 1, :integer
    planet.density = metric_value_to_f paragraphs[19].inner_html
    planet.surface_area = scientific_notation paragraphs[21].inner_html, 2, :integer
    planet.surface_gravity = metric_value_to_f paragraphs[23].inner_html
    planet.escape_velocity = scientific_notation paragraphs[25].inner_html, 2, :integer
    planet.sidereal_rotation_period = precise_value_to_f paragraphs[27].inner_html, 1
    tmp = paragraphs[29].inner_html
    planet.minimum_surface_temperature = temperature tmp, :min
    planet.maximum_surface_temperature = temperature tmp, :max
    planet.atm_els = AtmEl.create(atmospheric_constituents(paragraphs[31].inner_html))
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

  def temperature(paragraph, field)
    temperature = paragraph.split('<br>')[2].split('</b>').last.split('/')
    if temperature.size > 1
      min_max_value(temperature, field)
    else
      temperature.first.to_i
    end
  end

  def scientific_notation(paragraph, position, type)
    str = paragraph.split('<br>')[position].split('</b>').last.split('x')
    significand = BigDecimal(str.first)
    exposant = str.last.scan(/<sup>([^<>]*)<\/sup>/).flatten.first.to_i
    bigdecimal_to_type(significand * (10 ** exposant), type)
  end

  def precise_value_to_f(paragraph, position)
    paragraph.split('<br>')[position].to_f
  end

  def metric_value_to_f(paragraph)
    paragraph.split('<br>').first.split('</b>').last.to_f
  end

  def min_max_value(values, side)
    value = case side
    when :min then values.first
    when :max then values[1]
    end
    value.to_i
  end

  def atmospheric_constituents(str)
    return [] unless has_atmospheric_constituents?(str)
    splitted = str.split('<br>')
    names = atm_el_names(splitted)
    formula = atm_el_formula(splitted)
    names.each_with_index.map do |n, i|
      { name: n, chemical_formula: formula[i] }
    end
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

  def has_atmospheric_constituents?(str)
    str.split('<br>').size > 2
  end

  def atm_el_names(arr)
    arr.first.split(',').map { |e| e.strip }
  end

  def atm_el_formula(arr)
    elements = arr[1].split(':').last.split(',').map { |e| e.strip }
    elements.map do |e|
      formulify e.sub('</b>', '').strip
    end
  end

  def formulify(str)
    str.sub('<sub>2</sub>', '₂')
       .sub('<sub>3</sub>', '₃')
       .sub('<sub>4</sub>', '₄')
       .sub('<sub>5</sub>', '₅')
       .sub('<sub>6</sub>', '₆')
       .sub('<sub>7</sub>', '₇')
       .sub('<sub>8</sub>', '₈')
       .sub('<sub>9</sub>', '₉')
  end
end
