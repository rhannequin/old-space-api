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

      it 'returns correct value from #scientific_notation' do
        value1 = parser.scientific_notation " <b></b><br><b></b><br><b></b> 1.2345 x 10<sup>4</sup> m/s<br><b></b><br> ", 2, :float
        value2 = parser.scientific_notation " <b></b><br><b></b><br><b></b> 1.23456 x 10<sup>3</sup> m/s<br><b></b><br> ", 2, :float
        value3 = parser.scientific_notation " <b></b><br><b></b><br><b></b> 0.1234 x 10<sup>8</sup> m/s<br><b></b><br> ", 2, :float
        value4 = parser.scientific_notation " <b></b><br><b></b><br><b></b> 0.1234 x 10<sup>8</sup> m/s<br><b></b><br> ", 2, :integer
        value5 = parser.scientific_notation " <b></b><br><b></b> 1.2345 x 10<sup>5</sup> kg<br><b></b><br> ", 1, :float
        expect(value1).to be_kind_of(Float)
        expect(value1).to eq(12345.0)
        expect(value2).to eq(1234.56)
        expect(value3).to eq(12340000.0)
        expect(value4).to eq(12340000)
        expect(value5).to eq(123450.0)
      end
    end
  end
end
