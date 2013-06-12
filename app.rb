# encoding: UTF-8
require 'sinatra'
require 'sinatra/reloader'

require 'haml'
require 'json'
require 'open-uri'
require 'nokogiri'

configure :development do
  set :logging, true
  register Sinatra::Reloader
end

# Logger
def log(arg, method = "info")
  logger.send(method, arg)
end

def parse_html_file(url)
  file = open(url)
  Nokogiri::HTML(file.read.gsub("&nbsp;", ' '))
end

class SpaceApi < Sinatra::Application

  helpers do
    def json_response(code, response)
      content_type :json
      status code
      response[:code] = code
      if prettify?
        return JSON.pretty_generate response
      else
        return response.to_json
      end
    end
    def accept_params(params, *fields)
      h = {}
      fields.each do |name|
        h[name] = params[name] if params[name]
      end
      h
    end
    def prettify?
      not(!params[:pretty].nil? && params[:pretty] == 'false')
    end
  end

  get '/' do
    haml :index, :locals => {:title => 'Space API'}
  end

  get '/api/sun' do
    require './models/Sun'
    new_params = accept_params params, :lat, :lng, :loc, :alt, :tz
    sun = Sun.new
    sun.add_params(new_params) if new_params.any?
    json_response 200, { :data => sun.parse }
  end

end