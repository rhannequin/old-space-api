class AtmEl < ActiveRecord::Base
  belongs_to :atmosphereable, polymorphic: true
end
