class State < ActiveRecord::Base
  has_one :region, :through => :region_states
  has_one :region_state

  # should i use validates format of?
  #validates_format_of :abbrev, :with => /^[A-Z]{2}$/i, :message => "Must be a valid state abbreviation"
  validates :abbrev, :presence => true, :format => {:with => /^[A-Z]{2}$/, :message => "must be an uppercase two letter abbreviation"}

  #STATES SHOULD BE CACHED ON APPLICATION LOAD!!!!!!
  #     Best way to do this?
  #     Name and Abbrev only?  If so, best way to pull state rep when its time?

  def self.load_from_yaml
    states_yml = YAML::load_file(File.join(Rails.root, 'db/seeds','states.yml'))
    states_yml.each { |state| State.create!(state) }
  end
end
