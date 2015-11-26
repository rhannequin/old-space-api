require 'rails_helper'

describe 'One Planet', type: :request do
  it 'has created values' do
    planet = create :planet
    get "/api/v1/planets/#{planet.id}"
    expect(json['name']).to eq(planet.as_json['name'])
    expect(json['mean_orbital_velocity']).to eq(planet.as_json['mean_orbital_velocity'])
    expect(json['surface_area']).to eq(planet.as_json['surface_area'])
  end

  it 'renders an error if the Planet does not exist' do
    get '/api/v1/planets/i-dont-exist'
    expect(json).to eq({ 'error' => 'Not Found', 'status' => 404 })
  end

  it 'does not include technical attributes' do
    planet = create :planet
    get "/api/v1/planets/#{planet.id}"
    keys = json.keys
    expect(keys).not_to include(*excluded_keys)
  end
end
