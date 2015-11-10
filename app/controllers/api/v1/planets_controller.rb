module Api
  module V1
    class PlanetsController < ApplicationController
      def index
        render json: Planet.all.to_json(except: %i( id slug created_at updated_at ))
      end
    end
  end
end
