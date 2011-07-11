class State < ActiveRecord::Base
  has_one :region, :through => :region_states
  has_one :region_state

  # should i use validates format of?
  #validates_format_of :abbrev, :with => /^[A-Z]{2}$/i, :message => "Must be a valid state abbreviation"
  validates :abbrev, :presence => true, :format => {:with => /^[A-Z]{2}$/, :message => "must be an uppercase two letter abbreviation"}
end
