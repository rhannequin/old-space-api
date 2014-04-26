ENV['RACK_ENV'] = 'test'

require 'test/unit'
require 'rack/test'
require_relative '../app'
require_relative '../space_api_helpers'

class Test::Unit::TestCase
  include Rack::Test::Methods
  include SpaceApi::Helpers

  def app
    SpaceApi::App
  end
end
