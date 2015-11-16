require 'rails_helper'

describe 'One Planet', type: :request do
  it 'has created values' do
    planet = create :planet
    get "/api/v1/planets/#{planet.id}"
    expect(json).to eq(planet.as_json)
  end

  it 'renders an error if the Planet does not exist' do
    get '/api/v1/planets/i-dont-exist'
    expect(json).to eq({ 'error' => 'Not Found', 'status' => 404 })
  end
end
