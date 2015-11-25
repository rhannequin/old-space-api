class Api::V1::Parser::Planets::ParsePlanetsFromNssdcGsfcNasaGov
  attr_accessor :document, :lines, :properties, :properties_lines, :obj

  def self.uri(planet)
    "http://nssdc.gsfc.nasa.gov/planetary/factsheet/#{planet}fact.html"
  end

  def initialize(document)
    @document = document
    @obj = {}
    set_properties
  end

  def properties
    set_lines
    set_properties_lines
    insert_values
    obj
  end

  def set_lines
    @lines = document.split("\r")
  end

  def set_properties_lines
    @properties_lines = @properties.map do |p|
      pattern = p[:pattern]
      lines.index do |line|
        if pattern.kind_of?(Array)
          pattern.any? { |p| line.include?(p) }
        else
          line.include?(pattern)
        end
      end
    end
  end

  def insert_values
    properties_lines.each_with_index do |line_index, i|
      values = lines[line_index].split('  ').delete_if { |c| c.empty? || c.blank? }
      value = values[values.size - 3].strip.gsub(/,/, '')
      key = @properties[i][:key]
      lb = @properties[i][:lb]
      bd = BigDecimal(value)
      @obj[key] = lb ? lb.call(bd).to_f : bd.to_f
    end
  end

  def set_properties
    @properties = [
      { pattern: 'Mass', key: :mass, lb: -> (v) { v * (10 ** 24) } },
      { pattern: 'Volume', key: :volume, lb: -> (v) { v * (10 ** 10) } },
      { pattern: 'Equatorial', key: :equatorial_radius },
      { pattern: 'Polar', key: :polar_radius },
      { pattern: 'Volumetric', key: :volumetric_mean_radius },
      { pattern: 'Ellipticity', key: :ellipticity },
      { pattern: 'Mean density', key: :density },
      { pattern: ['Gravity', 'Surface gravity'], key: :surface_gravity },
      { pattern: ['Acceleration', 'Surface acceleration'], key: :acceleration },
      { pattern: 'Escape velocity', key: :escape_velocity },
      { pattern: 'GM', key: :standard_gravitational_parameter, lb: -> (v) { v * (10 ** 6) } },
      { pattern: 'Bond albedo', key: :bond_albedo },
      { pattern: 'Visual geometric albedo', key: :visual_geometric_albedo },
      { pattern: 'Visual magnitude', key: :visual_magnitude },
      { pattern: 'Solar irradiance', key: :solar_irradiance },
      { pattern: 'Black-body', key: :black_body_temperature },
      { pattern: 'Semimajor', key: :semimajor_axis, lb: -> (v) { v * (10 ** 6) } },
      { pattern: 'Sidereal orbit', key: :sidereal_orbit_period },
      { pattern: 'Tropical orbit', key: :tropical_orbit_period },
      { pattern: 'Perihelion', key: :perihelion, lb: -> (v) { v * (10 ** 6) } },
      { pattern: 'Aphelion', key: :aphelion, lb: -> (v) { v * (10 ** 6) } },
      { pattern: 'Max. orbital velocity', key: :maximum_orbital_velocity },
      { pattern: 'Min. orbital velocity', key: :minimum_orbital_velocity },
      { pattern: 'Orbit inclination', key: :orbit_inclination },
      { pattern: 'Length of day', key: :length_of_day },
      { pattern: 'Obliquity', key: :obliquity_to_orbit }
    ]
  end
end
