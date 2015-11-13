require 'spec_helper'

p = ParsePlanets.new
# uris = p.planets
uris = [p.planets.first]
documents = uris.map { |u| p.get_content(u) }

describe 'ParserPlanets' do
  let(:parser) { ParsePlanets.new }
  let(:contents) { documents.map { |d| d[:content] } }
  let(:names) { documents.map { |d| d[:name] } }
  let(:contents_paragraphs) { contents.map { |c| c.css('p') } }

  uris.each_with_index do |_, i|
    describe '' do
      let(:name) { names[i] }
      let(:content) { contents[i] }
      let(:paragraphs) { contents_paragraphs[i] }

      it 'returns a valid Planet' do
        planet = parser.parse_planet(name, content)
        expect(planet).to be_valid
      end

      it 'returns correct value from #discover_date_and_people' do
        paragraph = paragraphs[1].inner_html
        date = parser.discover_date_and_people paragraph, :date_of_discovery
        people = parser.discover_date_and_people paragraph, :discovered_by
        expect(date).to be_kind_of(String)
        expect(date).not_to be_empty
        expect(people).to be_kind_of(String)
        expect(people).not_to be_empty
      end
    end
  end
end
