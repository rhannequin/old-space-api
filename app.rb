$stdout.sync = true
require 'sinatra'
require 'sinatra/reloader'

require 'haml'
require 'json'

configure do
  set :api_name, 'Space API'
  set :repo_url, 'https://github.com/rhannequin/space-api'
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
    haml :index, :locals => {:title => settings.api_name, :name => 'home'}
  end

  get '/api/sun' do
    require './models/Sun'
    new_params = accept_params params, :lat, :lng, :alt, :tz
    sun = Sun.new
    sun.add_params(new_params) if new_params.any?
    json_response 200, { :data => sun.parse }
  end

  get '/api/planets/mercury' do
    require './models/Mercury'
    mercury = Mercury.new
    json_response 200, { :data => mercury.parse }
  end

  get '/api/planets/venus' do
    require './models/Venus'
    venus = Venus.new
    json_response 200, { :data => venus.parse }
  end

  get '/api/planets/earth' do
    require './models/Earth'
    earth = Earth.new
    json_response 200, { :data => earth.parse }
  end

  # Docs
  get '/docs' do
    haml :'docs/index', :locals => {:title => 'Home', :name => 'docs'}, :layout => :'docs/layout'
  end

  get '/docs/sun' do
    haml :'docs/sun', :layout => :'docs/layout', :locals => {
      :title => 'Sun',
      :name => 'docs-sun',
      :sun_api_url => "#{settings.api_url}/sun"
    }
  end

  get '/docs/planets/mercury' do
    haml :'docs/planets/mercury', :layout => :'docs/layout', :locals => {
      :title => 'Mercury',
      :name => 'docs-mercury',
      :mercury_api_url => "#{settings.api_url}/planets/mercury"
    }
  end

  get '/docs/planets/venus' do
    haml :'docs/planets/venus', :layout => :'docs/layout', :locals => {
      :title => 'Venus',
      :name => 'docs-venus',
      :venus_api_url => "#{settings.api_url}/planets/venus"
    }
  end

  get '/docs/planets/earth' do
    haml :'docs/planets/earth', :layout => :'docs/layout', :locals => {
      :title => 'Earth',
      :name => 'docs-earth',
      :earth_api_url => "#{settings.api_url}/planets/earth"
    }
  end

  get '/docs/about' do
    haml :'docs/about', :locals => {:title => 'About', :name => 'docs-about'}, :layout => :'docs/layout'
  end

  not_found do
    haml :not_found, :locals => {:title => "You're lost in outer space...", :name => 'not-found'}
  end

end