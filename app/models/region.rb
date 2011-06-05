class Region < ActiveRecord::Base
  has_many :region_states
  has_many :states, :through => :region_states

  validates_presence_of :name
end

# REGIONS MODEL =====================
# TODO: validations