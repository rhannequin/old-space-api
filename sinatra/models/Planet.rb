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
    hash
  end

  def parse_planet(document)
    index = 0
    hash = Hash.new
    # Get all <tr>
    trs = document.css('table.standardTable').first.css('tr')
    # Define planet's index
    trs.first.css('td').each_with_index do |tr, i|
      name = tr.text.downcase
      if name.size > 0 && name == @planet_name
        index = i
        break
      end
    end
    # Remove head <tr>
    trs.shift
    # Define properties
    trs.each do |tr|
      inject = true
      tds = tr.css('td')
      # Define property's label
      label = to_label tds.first.text
      # Get planet's value
      value = tds.css('td')[index].text
      # Set better labels
      case label
      when :range_au
        label = :range
      when :"max._eastern_elongation"
        label = :max_eastern_elongation
      when :"max._western_elongation"
        label = :max_western_elongation
      when :perihelion
        label = :perihelion_date
      when :aphelion
        label = :aphelion_date
      end

      # Clean date values
      case label
      when :inferior_conjunction, :opposition, :superior_conjunction,
           :max_eastern_elongation, :max_western_elongation,
           :perihelion_date, :aphelion_date
        if value == '-'
          inject = false
        else
          value = create_two_dates value
        end
      when :range, :brightness, :altitude, :azimuth
        value = value.to_f
      end
      hash[label] = value if inject
    end
    hash
  end

  def create_two_dates(v)
    date_names = Hash[Date::ABBR_MONTHNAMES.map.with_index.to_a]
    split = v.split('-')
    first_date = "#{split[0]}-#{sprintf('%02d', date_names[split[1]])}-#{split[2][0, 2]}"
    second_date = "#{split[2][2, 6]}-#{sprintf('%02d', date_names[split[3]])}-#{split[4]}"
    return "#{first_date} / #{second_date}"
  end

end