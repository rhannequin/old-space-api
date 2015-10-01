Kernel::require_relative 'Parent'
require 'date'

class MoonNow < Parent

  def initialize(config)
    @urls = %w(http://www.heavens-above.com/moon.aspx)
    super config
  end

  def parse
    document = load.first.css('#aspnetForm table')[3]
    hash = {
      altitude:               document.css('#ctl00_cph1_lblAltitude').text.strip.to_f,
      azimuth:                document.css('#ctl00_cph1_lblAzimuth').text.strip.to_f,
      right_ascension:        document.css('#ctl00_cph1_lblRA').text.strip,
      declination:            document.css('#ctl00_cph1_lblDec').text.strip,
      range:                  document.css('#ctl00_cph1_lblRange').text.strip.to_f,
      constellation:          document.css('#ctl00_cph1_linkConstellation').text.strip,
      diameter:               document.css('#ctl00_cph1_lblDiameter').text.strip.to_f,
      illumination_of_disk:   document.css('#ctl00_cph1_lblPercentIllumination').text.strip.to_f,
      libration_in_longitude: document.css('#ctl00_cph1_lblLibLong').text.strip.to_f,
      libration_in_latitude:  document.css('#ctl00_cph1_lblLibLat').text.strip.to_f,
      sets: {
        time:                 document.css('#ctl00_cph1_lblSetTime').text.strip,
        altitude:             document.css('#ctl00_cph1_lblSetAlt').text.strip.to_f,
        azimuth:              document.css('#ctl00_cph1_lblSetAz').text.strip.to_f
      },
      rises: {
        time:                 document.css('#ctl00_cph1_lblRiseTime').text.strip,
        altitude:             document.css('#ctl00_cph1_lblRiseAlt').text.strip.to_f,
        azimuth:              document.css('#ctl00_cph1_lblRiseAz').text.strip.to_f
      },
      maximum_altitude: {
        time:                 document.css('#ctl00_cph1_lblMaxAltTime').text.strip,
        altitude:             document.css('#ctl00_cph1_lblMaxAlt').text.strip.to_f,
        azimuth:              document.css('#ctl00_cph1_lblMaxElevAz').text.strip.to_f
      }
    }

    strptime = lambda do |datetime|
      DateTime.strptime(datetime.text.strip, '%d %B %Y %H:%M').to_datetime
    end

    yearly = document.css('table')[3].css('tr td')
    monthly_phases = {
      previous_new_moon: strptime.call(yearly[2]),
      first_quarter:     strptime.call(yearly[4]),
      full_moon:         strptime.call(yearly[6]),
      last_quarter:      strptime.call(yearly[8]),
      next_new_moon:     strptime.call(yearly[10])
    }
    hash = hash.merge monthly_phases

    return hash
  end

end