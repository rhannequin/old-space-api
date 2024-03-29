module Api
  module V1
    class PlanetsController < ApplicationController
      include ActionController::MimeResponds
      before_action :set_planet, only: :show

      def index
        planet = Planet.includes(:atm_els)
        respond_to do |format|
          format.xml  { render xml: planet.to_xml(data_configuration) }
          format.json { render json_reponse planet.to_json(data_configuration) }
        end
      end

      def show
        respond_to do |format|
          format.xml  { render xml: @planet.to_xml(data_configuration) }
          format.json { render json_reponse @planet.to_json(data_configuration) }
        end
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

      def data_configuration
        { except: ATTR_EXCLUDE, include: [atm_els: { except: ATTR_EXCLUDE }] }
      end
    end
  end
end
