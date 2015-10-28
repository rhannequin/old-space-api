class PlanetTmp
  include Mongoid::Document

  field :slug, type: String
  field :name, type: String
  field :date_of_discovery, type: String
end
