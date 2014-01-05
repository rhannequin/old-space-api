require 'open-uri'
require 'nokogiri'

class Sun
  include Mongoid::Document

  # Default values

  field :url                             , type: String
  field :discovered_by                   , type: String
  field :date_of_discovery               , type: String
  field :equatorial_inclination_to_orbit , type: Float
  field :mean_radius                     , type: Float
  field :equatorial_circumference        , type: Float
  field :volume                          , type: Float
  field :mass                            , type: Float
  field :density                         , type: Float
  field :surface_area                    , type: Float
  field :surface_gravity                 , type: Float
  field :escape_velocity                 , type: Float
  field :sidereal_rotation_period        , type: Float
  field :minimum_surface_temperature     , type: Integer
  field :maximum_surface_temperature     , type: Integer
  field :effective_temperature           , type: Integer
  field :spectral_type                   , type: Float
  field :age                             , type: Float
  field :hydrogen                        , type: Float
  field :helium                          , type: Float
  field :synodic_period                  , type: Float
  field :rotation_period_at_equator      , type: Float
  field :rotation_period_at_poles        , type: Float
  field :velocity_relative_to_near_stars , type: Float
  field :mean_distance_to_earth          , type: Float

  # Dynamic values

  field :astronomical_twilight_begins    , type: Hash
  field :nautical_twilight_begins        , type: Hash
  field :civil_twilight_begins           , type: Hash
  field :sunrise                         , type: Hash
  field :maximum_altitude                , type: Hash
  field :sunset                          , type: Hash
  field :civil_twilight_ends             , type: Hash
  field :nautical_twilight_ends          , type: Hash
  field :astronomical_twilight_ends      , type: Hash
  field :minimum_altitude                , type: Hash
  field :spring_equinox                  , type: DateTime
  field :summer_solstice                 , type: DateTime
  field :autumn_equinox                  , type: DateTime
  field :winter_solstice                 , type: DateTime
  field :altitude                        , type: Float
  field :azimuth                         , type: Float
  field :right_ascension                 , type: String
  field :declination                     , type: String
  field :range                           , type: Float
  field :constellation                   , type: String

  def self.prepare
    self.delete_all
    self.create initial_values.merge(parse)
  end

  def self.initial_values
    {
      url:                             'http://solarsystem.nasa.gov/planets/profile.cfm?Object=Sun&Display=Facts&System=Metric',
      discovered_by:                   'Known by the Ancients',
      date_of_discovery:               'Unknown',
      equatorial_inclination_to_orbit: 7.25,                            # °
      mean_radius:                     6.95508 * (10 ** 5),             # km
      equatorial_circumference:        4.3700056 * (10 ** 5),           # km
      volume:                          1.40927256905986 * (10 ** 18),   # km^3
      mass:                            1.9891 * (10 ** 30),             # kg
      density:                         1.409,                           # g/cm^3 # /!\
      surface_area:                    6.078747774547 * (10 ** 12),     # km^2
      surface_gravity:                 274,                             # m/s^2
      escape_velocity:                 6.177 * (10 ** 5),               # m/s /!\
      sidereal_rotation_period:        609.12,                          # hour
      minimum_surface_temperature:     5500,                            # °C
      maximum_surface_temperature:     5500,                            # °C
      effective_temperature:           5777,                            # K
      spectral_type:                   3.83 * (10 ** 33),               # ergs/sec
      age:                             4.6 * (10 ** 9),                 # year
      hydrogen:                        92.1,                            # %
      hydrogen:                        7.8,                             # %
      synodic_period:                  27.2753,                         # day
      rotation_period_at_equator:      26.8,                            # day
      rotation_period_at_poles:        36,                              # days
      velocity_relative_to_near_stars: 19.7,                            # km/s
      mean_distance_to_earth:          1.496 * (10 ** 8)                # km
    }
  end

  def self.parse
    document = Nokogiri::HTML(open('http://www.heavens-above.com/sun.aspx').read.gsub("&nbsp;", ' '))
    hash = Hash.new
    tables = document.css('table.standardTable')

    stop = false
    tables.first.css('tr').each do |tr|
      if !stop then stop = true; next end
      # Get <td>s as array
      content = tr.css('td').to_a
      label = to_label content[0].content
      hash[label] = {
        time:     content[1].content.strip,
        altitude: content[2].content.strip.to_f,
        azimuth:  content[3].content.strip.to_f
      }
    end

    yearly = tables[1]
    yearly_tr = yearly.css('tr')
    strptime = lambda do |datetime|
      DateTime.strptime(datetime.text.strip, '%b %d, %H:%M').to_datetime
    end
    hash[:spring_equinox]  = strptime.call(yearly_tr[1].css('td')[1])
    hash[:summer_solstice] = strptime.call(yearly_tr[2].css('td')[1])
    hash[:autumn_equinox]  = strptime.call(yearly_tr[3].css('td')[1])
    hash[:winter_solstice] = strptime.call(yearly_tr[4].css('td')[1])

    current_position = tables[2]
    current_position_tr = current_position.css('tr')
    hash[:altitude]        = current_position_tr[0].css('td')[1].text.strip.to_f
    hash[:azimuth]         = current_position_tr[1].css('td')[1].text.strip.to_f
    hash[:right_ascension] = current_position_tr[2].css('td')[1].text.strip
    hash[:declination]     = current_position_tr[3].css('td')[1].text.strip
    hash[:range]           = current_position_tr[4].css('td')[1].text.strip.to_f
    hash[:constellation]   = current_position_tr[5].css('td')[1].text.strip

    return hash
  end

  def self.to_label(str)
    str.strip.downcase.gsub(':', '').gsub(' ', '_').gsub('(', '').gsub(')', '').to_sym
  end
end
