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

  def str_to_num(str)
    case str
    when 'Jan'
      return 1
    when 'Feb'
      return 2
    when 'Mar'
      return 3
    when 'Apr'
      return 4
    when 'May'
      return 5
    when 'Jun'
      return 6
    when 'Jul'
      return 7
    when 'Aug'
      return 8
    when 'Sep'
      return 9
    when 'Oct'
      return 10
    when 'Nov'
      return 11
    when 'Dec'
      return 12
    end
  end

  def create_two_dates(v)
    split = v.split('-')
    first_date = Date.new(split[0].to_i, str_to_num(split[1]), split[2][0, 2].to_i).to_s
    second_date = Date.new(split[2][2, 6].to_i, str_to_num(split[3]), split[4].to_i).to_s
    return "#{first_date} / #{second_date}"
  end

end