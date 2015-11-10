require 'rails_helper'

describe 'List of Planets', type: :request do
  it 'responds successfully with an HTTP 200 status code' do
    get '/api/v1/planets'
    expect(json).to be_json_eql([])
  end
end
