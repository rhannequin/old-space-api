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
      properties = @properties[i]
      lb = properties[:lb]
      tp = properties[:type]
      bd = BigDecimal(value)
      @obj[properties[:key]] = lb ? lb.call(bd).public_send(tp) : bd.public_send(tp)
    end
  end

  def set_properties
    @properties = [
      { pattern: 'Mass', key: :mass, lb: -> (v) { v * (10 ** 24) }, type: :to_i },
      { pattern: 'Volume', key: :volume, lb: -> (v) { v * (10 ** 10) }, type: :to_i },
      { pattern: 'Equatorial', key: :equatorial_radius, type: :to_f },
      { pattern: 'Polar', key: :polar_radius, type: :to_f },
      { pattern: 'Volumetric', key: :volumetric_mean_radius, type: :to_f },
      { pattern: 'Ellipticity', key: :ellipticity, type: :to_f },
      { pattern: 'Mean density', key: :density, type: :to_i },
      { pattern: ['Gravity', 'Surface gravity'], key: :surface_gravity, type: :to_f },
      { pattern: ['Acceleration', 'Surface acceleration'], key: :acceleration, type: :to_f },
      { pattern: 'Escape velocity', key: :escape_velocity, type: :to_f },
      { pattern: 'GM', key: :standard_gravitational_parameter, lb: -> (v) { v * (10 ** 6) }, type: :to_f },
      { pattern: 'Bond albedo', key: :bond_albedo, type: :to_f },
      { pattern: 'Visual geometric albedo', key: :visual_geometric_albedo, type: :to_f },
      { pattern: 'Visual magnitude', key: :visual_magnitude, type: :to_f },
      { pattern: 'Solar irradiance', key: :solar_irradiance, type: :to_f },
      { pattern: 'Black-body', key: :black_body_temperature, type: :to_f },
      { pattern: 'Semimajor', key: :semimajor_axis, lb: -> (v) { v * (10 ** 6) }, type: :to_i },
      { pattern: 'Sidereal orbit', key: :sidereal_orbital_period, type: :to_f },
      { pattern: 'Tropical orbit', key: :tropical_orbital_period, type: :to_f },
      { pattern: 'Perihelion', key: :perihelion, lb: -> (v) { v * (10 ** 6) }, type: :to_i },
      { pattern: 'Aphelion', key: :aphelion, lb: -> (v) { v * (10 ** 6) }, type: :to_i },
      { pattern: 'Max. orbital velocity', key: :maximum_orbital_velocity, type: :to_f },
      { pattern: 'Min. orbital velocity', key: :minimum_orbital_velocity, type: :to_f },
      { pattern: 'Orbit inclination', key: :orbital_inclination, type: :to_f },
      { pattern: 'Length of day', key: :length_of_day, type: :to_f },
      { pattern: 'Obliquity', key: :equatorial_inclination, type: :to_f }
    ]
  end
end
