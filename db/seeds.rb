# ======================================
# STATES
# ======================================
puts 'Loading States'
states_yml = YAML::load_file(File.join(Rails.root, 'db/seeds','states.yml'))
states_yml.each { |state| State.create!(state) }

#TODO: provinces?
#states.each do |s|
#  s = State.create!(s.merge(:state_rep_id => 0))
#end

# ======================================
# REGIONS
# ======================================
northeast = Region.create!(:name => 'Northeast', :description => 'Northeastern Regions')
southeast = Region.create!(:name => 'Southeast', :description => 'Florida')
greatlakes = Region.create!(:name => 'Great Lakes', :description => 'Chicago')
midwest = Region.create!(:name => 'Midwest', :description => 'Iowa')
northwest = Region.create!(:name => 'Northwest', :description => 'Oregon')
southwest = Region.create!(:name => 'Southwest', :description => 'Cali')
southcentral = Region.create!(:name => 'South Central', :description => 'Tejas')

northeast.states << State.where(:abbrev => ['ME', 'VT', 'NH', 'MA', 'RI', 'NY', 'PA', 'MD', 'DE', 'DC', 'WV', 'VA'])
southeast.states << State.where(:abbrev => ['TN', 'NC', 'SC', 'GA', 'MS', 'AL', 'FL'])
greatlakes.states << State.where(:abbrev => ['OH', 'KY', 'IL', 'IN', 'MI', 'WI', 'MO'])
midwest.states << State.where(:abbrev => ['IA', 'MN', 'ND', 'SD', 'MT', 'WY', 'CO', 'UT'])
northwest.states << State.where(:abbrev => ['WA', 'ID', 'OR', 'AK'])
southwest.states << State.where(:abbrev => ['CA', 'AZ', 'NV', 'HI'])
southcentral.states << State.where(:abbrev => ['AS', 'LA', 'TX', 'OK', 'KS', 'NM'])

# ======================================
# RINKS
# ======================================
# TODO: handle internation rinks
# TODO: better handle
puts 'Creating Rinks'
rinks_yml = YAML::load_file(File.join(Rails.root, 'db/seeds','rinks.yml'))
rinks_yml.each { |r|
  #puts r[:name]
  addy = Address.new(r[:address])
  if addy.valid?
    rink = Rink.new(r)
    rink.address = addy
    rink.save
  end
}

#TODO: Store lat and long with addresses to avoid Geocode Calls!!
puts 'Rinks Created'
puts '  run `rake addresses:geocode` to geocode'
puts '  (rink addresses should already be geocoded)'

# ======================================
# MEMBERS
# ======================================
# TODO: hard code basic admin users
# TODO: hard code basic manager users
puts 'Creating Admin Accounts'
admins = [
  {:first_name => 'David',   :last_name => 'Conner',    :email => 'dconner.pro@gmail.com', :birthday => '5/11/1986'},
  {:first_name => 'System',  :last_name => 'Admin',     :email => 'admin@somewebsite.com', :birthday => '12/21/2012'}]

admins.each do |person|
  member = Member.create!(person.merge(:password => 'password!'))
  member.assign_role(:appadmin)
end

puts 'Creating Member Accounts'
5.times { Factory(:member) }

