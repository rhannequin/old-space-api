Kernel::require_relative 'Parent'
require 'date'

class Sun < Parent

  def initialize
    @urls = ['http://www.heavens-above.com/sun.aspx']
  end

  def parse
    document = load.first
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

end