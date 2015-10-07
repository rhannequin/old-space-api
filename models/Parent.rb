require 'open-uri'
require 'nokogiri'

class Parent
  attr_accessor :uri
  attr_accessor :config

  def initialize(config)
    @config = config
  end

  def load
    documents = []
    @urls.each do |uri|
      file = get_content(uri)
      documents << Nokogiri::HTML(file.read.gsub("&nbsp;", ' '))
    end
    documents
  end

  def to_label(str)
    return str.strip.downcase.gsub(':', '').gsub(' ', '_').gsub('(', '').gsub(')', '').to_sym
  end

  def add_params(params)
    @urls.map! { |uri| uri + '?' + params.map{ |k, v| "#{k}=#{v}" }.join('&') }
  end

  def get_content(uri)
    proxy = @config.proxy_use ? {
      proxy_http_basic_authentication: [
        "#{@config.proxy_url}:#{@config.proxy_port}",
        @config.proxy_username,
        @config.proxy_password
      ]
    } : {}
    open uri, proxy
  end
end