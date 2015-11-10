require 'rails_helper'

describe Api::V1::PlanetsController, type: :controller do
  describe 'GET #index' do
    it 'responds successfully with an HTTP 200 status code' do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show' do
    it 'responds successfully with an HTTP 200 status code' do
      planet = create(:planet)
      get :show, id: planet.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'can be accessed from slug' do
      planet = create(:planet, name: 'My Planet')
      get :show, id: 'my-planet'
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end
end
