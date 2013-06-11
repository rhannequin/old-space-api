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

## logger
def log(arg, method = "info")
  logger.send(method, arg)
end

class SpaceApi < Sinatra::Application

  get '/' do
    haml :index, :locals => {:title => "Space API"}
  end

end