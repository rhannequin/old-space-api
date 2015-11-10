module Api
  module V1
    class PlanetsController < ApplicationController
      def index
        render json: Planet.all.to_json
      end
    end
  end
end
