module Api
  module V1
    class PlanetsController < ApplicationController
      def index
        render json: []
      end
    end
  end
end
