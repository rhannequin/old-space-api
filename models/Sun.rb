Kernel::require_relative 'Parent'

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
        :time     => content[1].content.strip,
        :altitude => content[2].content.strip,
        :azimuth  => content[3].content.strip
      }
    end

    yearly = tables[1]
    stop = false
    yearly.css('tr').each do |tr|
      if !stop then stop = true; next end
      # Get <td>s as array
      content = tr.css('td').to_a
      label = to_label content[0].content.strip

      hash[label] = content[1].text.strip
    end

    current_position = tables[2]
    current_position.css('tr').each do |tr|
      # Get <td>s as array
      content = tr.css('td')
      label = to_label content[0].content

      hash[label] = content[1].text.strip
    end
    return hash
  end

end