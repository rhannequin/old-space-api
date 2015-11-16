module Cleanable
  extend ActiveSupport::Concern

  def as_json(options={})
    super(except: %i( id slug created_at updated_at ))
  end
end
