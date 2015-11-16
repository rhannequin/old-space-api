require 'spec_helper'

shared_examples_for 'cleanable' do
  let(:model) { described_class } # the class that includes the concern

  it 'converts to json without technical attributes' do
    obj = FactoryGirl.create model.to_s.underscore.to_sym
    keys = obj.as_json.keys
    exclude = %w( id slug created_at updated_at )
    expect(keys).not_to include(*exclude)
  end
end
