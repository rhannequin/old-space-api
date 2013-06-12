class Parent
  attr_accessor :url
  def load
    file = open(@url)
    Nokogiri::HTML(file.read.gsub("&nbsp;", ' '))
  end

  def to_label(str)
    return str.strip.downcase.gsub(':', '').gsub(' ', '_').gsub('(', '').gsub(')', '').to_sym
  end

  def add_params(params)
    @url = @url + '?' + params.map{ |k, v| "#{k}=#{v}" }.join('&')
  end
end