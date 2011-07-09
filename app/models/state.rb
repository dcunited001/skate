class State < ActiveRecord::Base
  has_one :region, :through => :region_states
  has_one :region_state

  validates_format_of :abbrev, :with => /^[A-Z]{2}$/i, :message => "Must be a valid state abbreviation"
end
