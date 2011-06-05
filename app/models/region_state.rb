class RegionState < ActiveRecord::Base
  belongs_to :region
  belongs_to :state
end

