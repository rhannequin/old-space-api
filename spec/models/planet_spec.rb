require 'rails_helper'

describe Planet, type: :model do
  let(:planet) { create :planet }

  it 'is well implemeted' do
    expect(planet).to be_a(Planet)
  end
end
