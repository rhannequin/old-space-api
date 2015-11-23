require 'rails_helper'

describe Planet, type: :model do

  it 'is well implemeted' do
    planet = create :planet
    expect(planet).to be_a(Planet)
  end

  describe 'Slug' do
    it 'is created from "name" attribute' do
      mercury = create(:planet, name: 'Mercury')
      strange_name = create(:planet, name: 'Strange Name')
      expect(mercury.slug).to eq('mercury')
      expect(strange_name.slug).to eq('strange-name')
    end
  end
end
