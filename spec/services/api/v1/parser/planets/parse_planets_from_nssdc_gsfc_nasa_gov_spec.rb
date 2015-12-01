require 'rails_helper'

M = Api::V1::Parser::Planets
PP = M::ParsePlanets.new
NG = M::ParsePlanetsFromNssdcGsfcNasaGov

planets = PP.planets
documents = planets.map { |planet| PP.get_content(NG.uri(planet)) }

describe 'ParsePlanetsFromSolarsystemNasaGov' do
  let(:parsers) { documents.map { |d| NG.new(d) } }

  planets.each_with_index do |_, i|
    describe '' do
      let(:parser) { parsers[i] }
      let(:document) { parser.document }
      let(:properties) { parser.properties }

      it 'as a document with each keyword' do
        [
          'Mass', 'Volume', 'Equatorial', 'Polar', 'Volumetric', 'Ellipticity',
          'Mean density', 'Escape velocity', 'GM', 'Bond albedo',
          'Visual geometric albedo', 'Visual magnitude', 'Solar irradiance',
          'Black-body', 'Semimajor', 'Sidereal orbit', 'Tropical orbit',
          'Perihelion', 'Aphelion', 'Max. orbital velocity',
          'Min. orbital velocity', 'Orbit inclination', 'Length of day',
          'Obliquity'
        ].each do |word|
          expect(document).to include(word)
        end
      end

      it 'as a document with one of each keyword' do
        [
          ['Gravity', 'Surface gravity'],
          ['Acceleration', 'Surface acceleration']
        ].each do |arr|
          expect(document).to satisfy do |d|
            arr.any? { |v| document.include?(v) }
          end
        end
      end

      it 'has value for each key' do
        %i( mass volume equatorial_radius polar_radius volumetric_mean_radius
            ellipticity density surface_gravity acceleration escape_velocity
            standard_gravitational_parameter bond_albedo visual_geometric_albedo
            visual_magnitude solar_irradiance black_body_temperature
            semimajor_axis sidereal_orbital_period tropical_orbital_period
            perihelion aphelion maximum_orbital_velocity
            minimum_orbital_velocity orbital_inclination length_of_day
            obliquity_to_orbit
        ).each do |k|
          expect(properties[k]).not_to be_nil
        end
      end
    end
  end
end
