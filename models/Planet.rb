Kernel::require_relative 'Parent'

class Planet < Parent

  def parse_planets(document)
    hash = Hash.new
    # Find table
    document.css('table.standardTable').each do |table|
      stop = false
      # Each tr except the head one
      table.css('tr').each do |tr|
        if !stop then stop = true; next end
        # Get <td>s as array
        content = tr.css('td').to_a
        name = content.first.text.downcase
        if @planet_name == name
          hash[:distance_from_sun] = content[1].text.to_f
          hash[:distance_from_earth] = content[2].text.to_f
          hash[:velocity] = content[3].text.to_f
          break
        end
      end
    end
    return hash
  end

end