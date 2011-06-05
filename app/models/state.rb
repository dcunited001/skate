class State < ActiveRecord::Base
  has_one :region, :through => :region_states
  has_one :region_state

  validates_format_of :name, :with => /^[a-zA-Z]{2}$/i, :message => "Must be a valid state abbreviation"
end



# STATES MODEL ======================
# TODO: relationships
# TODO: validations
# TODO: named scopes
# TODO: populated with data
# TODO: compatible with international?
# TODO: update existing addresses
# TODO: update address models

# TODO: need states controller?