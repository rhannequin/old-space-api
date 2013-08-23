$stdout.sync = true
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/cross_origin'

require 'haml'
require 'json'

configure do
  set :api_name, 'Space API'
  set :repo_url, 'https://github.com/rhannequin/space-api'
  enable :cross_origin
end
configure :development do
  set :logging, true
  set :api_url, 'http://localhost:5000/api'
  register Sinatra::Reloader
end
configure :production do
  set :api_url, 'https://space-api.herokuapp.com/api'
end

# Logger
def log(arg, method = 'info')
  logger.send(method, arg)
end

class SpaceApi < Sinatra::Application

  helpers do
    def json_response(code, response)
      cross_origin
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
    def h(text)
      Rack::Utils.escape_html(text)
    end
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
    if File.file? "#{class_path}.rb"
      require class_path
      planet_class = Object.const_get(planet_name.capitalize)
      new_params = accept_params params, :lat, :lng, :alt, :tz
      planet = planet_class.new
      planet.add_params(new_params) if new_params.any?
      json_response 200, { data: planet.parse }
    else
      redirect not_found
    end
  end

  # Docs
  get '/docs' do
    haml 'docs/index'.to_sym, {
      layout: 'docs/layout'.to_sym,
      locals: {
        title: 'Home',
        name: 'docs'
      }
    }
  end

  get '/docs/sun' do
    haml 'docs/sun'.to_sym, {
      layout: 'docs/layout'.to_sym,
      locals: {
        title:       'Sun',
        name:        'docs-sun',
        sun_api_url: "#{settings.api_url}/sun"
      }
    }
  end

  get '/docs/planets/:planet_name' do
    planet_name = params[:planet_name]
    if File.file? "#{File.dirname(__FILE__)}/models/#{planet_name.capitalize}.rb"
      haml 'docs/planets/planet'.to_sym, {
        layout: 'docs/layout'.to_sym,
        locals: {
          planet_name:    planet_name,
          title:          planet_name.capitalize,
          name:           "docs-#{planet_name}",
          planet_api_url: "#{settings.api_url}/planets/#{planet_name}"
        }
      }
    else
      redirect not_found
    end
  end

  get '/docs/about' do
    haml :'docs/about', {
      locals: {
        title: 'About',
        name:  'docs-about'
      },
      layout: 'docs/layout'.to_sym
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