# encoding: UTF-8
require 'sinatra'
require 'sinatra/reloader'

require 'json'
require 'open-uri'
require 'nokogiri'

configure :development do
  set :logging, true
  register Sinatra::Reloader
end

## logger
def logger
  @logger ||= Logger.new(STDOUT)
end

class SpaceApi < Sinatra::Application

  get '/' do
    "Hello"
  end

end