require 'rails_helper'

describe 'List of Planets', type: :request do
  before(:each) do
    @planets = create_list :planet, 2
  end

  it 'provides correct number of planets' do
    get '/api/v1/planets'
    expect(json.size).to eq(2)
  end

  it 'excludes technical fields' do
    get '/api/v1/planets'
    first_planet = json.first.to_json
    expect(first_planet).to have_json_path('name')
    expect(first_planet).not_to have_json_path('id')
    expect(first_planet).not_to have_json_path('slug')
    expect(first_planet).not_to have_json_path('created_at')
    expect(first_planet).not_to have_json_path('updated_at')
  end

  it 'has created values' do
    get '/api/v1/planets'
    first_planet_created = @planets.first
    first_planet_rendered = json.first
    expect(first_planet_rendered['name']).to eq(first_planet_created.name)
  end
end
