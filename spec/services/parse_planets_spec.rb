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

      it 'returns correct value from #temperature' do
        value1 = parser.temperature " <b></b><br><b></b><br><b>Scientific Notation:</b> 123/456 K<br><b></b><br> ", :max
        value2 = parser.temperature " <b></b><br><b></b><br><b>Scientific Notation:</b> 789 K<br><b></b><br> ", :min
        expect(value1).to be_kind_of(Integer)
        expect(value1).to eql(456)
        expect(value2).to be_kind_of(Integer)
        expect(value2).to eql(789)
      end

      it 'returns correct value from #scientific_notation' do
        value1 = parser.scientific_notation " <b></b><br><b></b><br><b></b> 1.2345 x 10<sup>4</sup> m/s<br><b></b><br> ", 2, :float
        value2 = parser.scientific_notation " <b></b><br><b></b><br><b></b> 1.23456 x 10<sup>3</sup> m/s<br><b></b><br> ", 2, :float
        value3 = parser.scientific_notation " <b></b><br><b></b><br><b></b> 0.1234 x 10<sup>8</sup> m/s<br><b></b><br> ", 2, :float
        value4 = parser.scientific_notation " <b></b><br><b></b><br><b></b> 0.1234 x 10<sup>8</sup> m/s<br><b></b><br> ", 2, :integer
        value5 = parser.scientific_notation " <b></b><br><b></b> 1.2345 x 10<sup>5</sup> kg<br><b></b><br> ", 1, :float
        expect(value1).to be_kind_of(Float)
        expect(value1).to eql(12345.0)
        expect(value2).to eql(1234.56)
        expect(value3).to eql(12340000.0)
        expect(value4).to eql(12340000)
        expect(value5).to eql(123450.0)
      end

      it 'returns correct value from #precise_value_to_f' do
        value1 = parser.precise_value_to_f " 0.123456<br><b></b><br> ", 0
        value2 = parser.precise_value_to_f " 1.2 degrees<br><b></b><br> ", 0
        value3 = parser.precise_value_to_f " 0<br><b></b><br> ", 0
        value4 = parser.precise_value_to_f " <br> 1234.5 Hours<br><b></b><br> ", 1
        expect(value1).to be_kind_of(Float)
        expect(value1).to eql(0.123456)
        expect(value2).to eql(1.2)
        expect(value3).to eql(0.0)
        expect(value4).to eql(1234.5)
      end

      it 'returns correct value from #metric_value_to_f' do
        value = parser.metric_value_to_f " <b>Metric:</b> 1.2 m/s<sup>2</sup><br><b></b><br><b><br> "
        expect(value).to be_kind_of(Float)
        expect(value).to eql(1.2)
      end

      it 'returns correct value from #min_max_value' do
        arr = [" 123", "456 K"]
        value1 = parser.min_max_value arr, :min
        value2 = parser.min_max_value arr, :max
        expect(value1).to be_kind_of(Integer)
        expect(value1).to eql(123)
        expect(value2).to be_kind_of(Integer)
        expect(value2).to eql(456)
      end

      it 'returns correct value from #atmospheric_constituents' do
        str1 = " <b>By Comparison:</b> Earth's atmosphere consists mostly of N<sub>2</sub>, O<sub>2</sub><br> "
        str2 = " Hydrogen, Helium<br> <b>Scientific Notation:</b> H<sub>2</sub>, He<br> "
        str3 = " Carbon Dioxide, Nitrogen<br> <b>Scientific Notation:</b> CO<sub>2</sub>, N<sub>2</sub><br> "
        value1 = parser.atmospheric_constituents str1
        value2 = parser.atmospheric_constituents str2
        value3 = parser.atmospheric_constituents str3
        expect(value1).to be_kind_of(Array)
        expect(value1).to be_empty
        expect(value2).to be_kind_of(Array)
        expect(value2.first).to eql({ name: 'Hydrogen', chemical_formula: 'H₂'})
        expect(value3).to be_kind_of(Array)
        expect(value3.first).to eql({ name: 'Carbon Dioxide', chemical_formula: 'CO₂'})
      end
    end
  end
end
