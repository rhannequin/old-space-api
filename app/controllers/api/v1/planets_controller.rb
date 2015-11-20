module Api
  module V1
    class PlanetsController < ApplicationController
      before_action :set_planet, only: :show

      def index
        render json: Planet.includes(:atm_els).to_json({ except: JSON_EXCLUDE, include: [{ atm_els: { except: JSON_EXCLUDE } }] })
      end

      def show
        render json: @planet.to_json(except: JSON_EXCLUDE, include: [atm_els: { except: JSON_EXCLUDE }])
      end

      private

      def set_planet
        begin
          @planet = Planet.includes(:atm_els).friendly.find name_from_params
        rescue ActiveRecord::RecordNotFound
          return render_not_found
        end
      end

      def name_from_params
        params.permit(:id).require(:id)
      end
    end
  end
end
