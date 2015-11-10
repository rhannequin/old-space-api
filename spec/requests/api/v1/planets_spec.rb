require 'rails_helper'

describe 'List of Planets', type: :request do
  before(:each) do
    @planets = create_list :planet, 2
  end

  it 'responds successfully with an HTTP 200 status code' do
    get '/api/v1/planets'
    expect(json.to_json).to eq(@planets.to_json)
  end
end
