require 'open-uri'
require 'nokogiri'

class Parent
  attr_accessor :url
  def load
    documents = []
    @urls.each do |url|
      file = open(url)
      documents << Nokogiri::HTML(file.read.gsub("&nbsp;", ' '))
    end
    documents
  end

  def to_label(str)
    return str.strip.downcase.gsub(':', '').gsub(' ', '_').gsub('(', '').gsub(')', '').to_sym
  end

  def add_params(params)
    @url = @url + '?' + params.map{ |k, v| "#{k}=#{v}" }.join('&')
  end
end