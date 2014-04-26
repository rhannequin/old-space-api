$stdout.sync = true
require 'sinatra/base'
require 'sinatra/cross_origin'
require 'sinatra/config_file'
require 'sinatra/namespace'
require 'sinatra/reloader'
require 'mongoid'

require 'logger'
require 'haml'
require 'json'

require_relative 'space_api_helpers'
require_relative 'require_models'

module SpaceApi

  class App < Sinatra::Base
    register Sinatra::ConfigFile
    register Sinatra::CrossOrigin
    register Sinatra::Namespace

    set :environments, %w(production development test)
    set :environment, (ENV['RACK_ENV'] || ENV['SPACEAPI_APPLICATION_ENV'] || :development).to_sym

    set :allow_origin,   :any
    set :allow_methods,  %w(:get)
    set :expose_headers, %w(Content-Type)

    config_file 'config_file.yml'

    configure do
      enable :logging
      enable :cross_origin
      Mongoid.load!('mongoid.yml')
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

    namespace '/api' do
      namespace '/sun' do
        get do
          sun = Sun.first
          json_response 200, { data: sun.render }
        end

        get '/now' do
          sun = SunNow.new
          new_params = accept_params params, :lat, :lng, :alt, :tz
          sun.add_params(new_params) if new_params.any?
          json_response 200, { data: sun.parse }
        end
      end

      namespace '/moon' do
        get do
          moon = Moon.first
          json_response 200, { data: moon.render }
        end

        get '/now' do
          moon = MoonNow.new
          new_params = accept_params params, :lat, :lng, :alt, :tz
          moon.add_params(new_params) if new_params.any?
          json_response 200, { data: moon.parse }
        end
      end

      get '/planets/:planet_name' do
        planet_name = params[:planet_name]
        class_path = "#{File.dirname(__FILE__)}/models/#{planet_name.capitalize}"
        return app_error_message(:not_found_error) unless File.file? "#{class_path}.rb"
        planet_class = Object.const_get(planet_name.capitalize)
        new_params = accept_params params, :lat, :lng, :alt, :tz
        planet = planet_class.new
        planet.add_params(new_params) if new_params.any?
        json_response 200, { data: planet.parse }
      end
    end

    # Docs
    namespace '/docs' do
      get do
        haml :'docs/index', {
          layout: :'docs/layout',
          locals: {
            title: 'Home',
            name: 'docs'
          }
        }
      end

      get '/sun' do
        haml :'docs/sun', {
          layout: :'docs/layout',
          locals: {
            title:       'Sun',
            name:        'docs-sun',
            sun_api_url: "#{settings.api_url}/sun"
          }
        }
      end

      get '/planets/:planet_name' do
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

      get '/about' do
        haml :'docs/about', {
          locals: {
            title: 'About',
            name:  'docs-about'
          },
          layout: :'docs/layout'
        }
      end
    end

    not_found do
      json_response 404, { error: 'Not found' }
    end
  end

end
