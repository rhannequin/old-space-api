class Planet < ActiveRecord::Base
  include Cleanable
  extend FriendlyId
  friendly_id :name, use: :slugged
end
