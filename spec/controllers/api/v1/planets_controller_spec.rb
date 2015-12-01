require 'rails_helper'

describe Api::V1::PlanetsController, type: :controller do
  describe 'GET #index' do
    it 'responds successfully with an HTTP 200 status code' do
      get :index, format: :json
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show' do
    it 'responds successfully with an HTTP 200 status code' do
      planet = create(:planet)
      get :show, id: planet.id, format: :json
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'can be accessed from slug' do
      planet = create(:planet, name: 'My Planet')
      get :show, id: 'my-planet', format: :json
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'returns an error if the Planet does not exist' do
      get :show, id: 'i-dont-exist', format: :json
      expect(response).not_to be_success
      expect(response).to have_http_status(404)
    end
  end
end
