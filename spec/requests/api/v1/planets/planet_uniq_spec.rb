require 'rails_helper'

describe 'One Planet', type: :request do
  it 'has created values' do
    planet = create :planet
    get "/api/v1/planets/#{planet.id}"
    expect(json).to eq(planet.as_json)
  end
end
