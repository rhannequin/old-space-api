$stdout.sync = true
require 'sinatra/base'
require 'sinatra/cross_origin'
require 'sinatra/config_file'
require 'sinatra/namespace'
require 'sinatra/reloader'

require 'logger'
require 'haml'
require 'json'

require_relative 'space_api_helpers'

module SpaceApi

  class App < Sinatra::Base
    register Sinatra::ConfigFile
    register Sinatra::CrossOrigin
    register Sinatra::Namespace

    set :environments, %w(production development test)
    set :environment, (ENV['RACK_ENV']||ENV['SPACEAPI_APPLICATION_ENV']||:development).to_sym

    set :allow_origin, :any
    set :allow_methods, %w(:get)
    set :expose_headers, %w(Content-Type)

    config_file 'config_file.yml'

    configure do
      enable :logging
      enable :cross_origin
    end

    configure :production do
      set :logging, Logger::INFO
    end

    configure :development do
      register Sinatra::Reloader
    end

    configure %w(development test) do
      set :logging, Logger::DEBUG
    end

    helpers do
      include SpaceApi::Helpers
    end

    get '/' do
      haml :index, {
        locals: {
          title: settings.api_name,
          name: 'home'
        }
      }
    end

    get '/api/sun' do
      require './models/Sun'
      new_params = accept_params params, :lat, :lng, :alt, :tz
      sun = Sun.new
      sun.add_params(new_params) if new_params.any?
      json_response 200, { data: sun.parse }
    end

    get '/api/planets/:planet_name' do
      planet_name = params[:planet_name]
      class_path = "#{File.dirname(__FILE__)}/models/#{planet_name.capitalize}"
      return app_error_message(:not_found_error) unless File.file? "#{class_path}.rb"
      require class_path
      planet_class = Object.const_get(planet_name.capitalize)
      new_params = accept_params params, :lat, :lng, :alt, :tz
      planet = planet_class.new
      planet.add_params(new_params) if new_params.any?
      json_response 200, { data: planet.parse }
    end

    # Docs
    get '/docs' do
      haml :'docs/index', {
        layout: :'docs/layout',
        locals: {
          title: 'Home',
          name: 'docs'
        }
      }
    end

    get '/docs/sun' do
      haml :'docs/sun', {
        layout: :'docs/layout',
        locals: {
          title:       'Sun',
          name:        'docs-sun',
          sun_api_url: "#{settings.api_url}/sun"
        }
      }
    end

    get '/docs/planets/:planet_name' do
      planet_name = params[:planet_name]
      return redirect not_found unless  File.file? "#{File.dirname(__FILE__)}/models/#{planet_name.capitalize}.rb"
      haml :'docs/planets/planet', {
        layout: :'docs/layout',
        locals: {
          planet_name:    planet_name,
          title:          planet_name.capitalize,
          name:           "docs-#{planet_name}",
          planet_api_url: "#{settings.api_url}/planets/#{planet_name}"
        }
      }
    end

    get '/docs/about' do
      haml :'docs/about', {
        locals: {
          title: 'About',
          name:  'docs-about'
        },
        layout: :'docs/layout'
      }
    end

    not_found do
      haml :not_found, {
        locals: {
          title: "You're lost in outer space...",
          name: 'not-found'
        }
      }
    end
  end

end
