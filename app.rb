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
    new_params = accept_params params, :lat, :lng, :alt, :tz
    mercury = Mercury.new
    mercury.add_params(new_params) if new_params.any?
    json_response 200, { :data => mercury.parse }
  end

  get '/api/planets/venus' do
    require './models/Venus'
    new_params = accept_params params, :lat, :lng, :alt, :tz
    venus = Venus.new
    venus.add_params(new_params) if new_params.any?
    json_response 200, { :data => venus.parse }
  end

  get '/api/planets/earth' do
    require './models/Earth'
    new_params = accept_params params, :lat, :lng, :alt, :tz
    earth = Earth.new
    earth.add_params(new_params) if new_params.any?
    json_response 200, { :data => earth.parse }
  end

  get '/api/planets/mars' do
    require './models/Mars'
    new_params = accept_params params, :lat, :lng, :alt, :tz
    mars = Mars.new
    mars.add_params(new_params) if new_params.any?
    json_response 200, { :data => mars.parse }
  end

  get '/api/planets/jupiter' do
    require './models/Jupiter'
    new_params = accept_params params, :lat, :lng, :alt, :tz
    jupiter = Jupiter.new
    jupiter.add_params(new_params) if new_params.any?
    json_response 200, { :data => jupiter.parse }
  end

  get '/api/planets/saturn' do
    require './models/Saturn'
    new_params = accept_params params, :lat, :lng, :alt, :tz
    saturn = Saturn.new
    saturn.add_params(new_params) if new_params.any?
    json_response 200, { :data => saturn.parse }
  end

  get '/api/planets/uranus' do
    require './models/Uranus'
    new_params = accept_params params, :lat, :lng, :alt, :tz
    uranus = Uranus.new
    uranus.add_params(new_params) if new_params.any?
    json_response 200, { :data => uranus.parse }
  end

  get '/api/planets/neptune' do
    require './models/Neptune'
    new_params = accept_params params, :lat, :lng, :alt, :tz
    neptune = Neptune.new
    neptune.add_params(new_params) if new_params.any?
    json_response 200, { :data => neptune.parse }
  end

  get '/api/planets/pluto' do
    require './models/Pluto'
    new_params = accept_params params, :lat, :lng, :alt, :tz
    pluto = Pluto.new
    pluto.add_params(new_params) if new_params.any?
    json_response 200, { :data => pluto.parse }
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

  get '/docs/planets/mars' do
    haml :'docs/planets/mars', :layout => :'docs/layout', :locals => {
      :title => 'Mars',
      :name => 'docs-mars',
      :mars_api_url => "#{settings.api_url}/planets/mars"
    }
  end

  get '/docs/planets/jupiter' do
    haml :'docs/planets/jupiter', :layout => :'docs/layout', :locals => {
      :title => 'Jupiter',
      :name => 'docs-jupiter',
      :jupiter_api_url => "#{settings.api_url}/planets/jupiter"
    }
  end

  get '/docs/planets/saturn' do
    haml :'docs/planets/saturn', :layout => :'docs/layout', :locals => {
      :title => 'Saturn',
      :name => 'docs-saturn',
      :saturn_api_url => "#{settings.api_url}/planets/saturn"
    }
  end

  get '/docs/planets/uranus' do
    haml :'docs/planets/uranus', :layout => :'docs/layout', :locals => {
      :title => 'Uranus',
      :name => 'docs-uranus',
      :uranus_api_url => "#{settings.api_url}/planets/uranus"
    }
  end

  get '/docs/planets/neptune' do
    haml :'docs/planets/neptune', :layout => :'docs/layout', :locals => {
      :title => 'Neptune',
      :name => 'docs-neptune',
      :neptune_api_url => "#{settings.api_url}/planets/neptune"
    }
  end

  get '/docs/planets/pluto' do
    haml :'docs/planets/pluto', :layout => :'docs/layout', :locals => {
      :title => 'Pluto',
      :name => 'docs-pluto',
      :pluto_api_url => "#{settings.api_url}/planets/pluto"
    }
  end

  get '/docs/about' do
    haml :'docs/about', :locals => {:title => 'About', :name => 'docs-about'}, :layout => :'docs/layout'
  end

  not_found do
    haml :not_found, :locals => {:title => "You're lost in outer space...", :name => 'not-found'}
  end

end