# ======================================
# ROLES
# ======================================
puts 'Creating Roles'
Role.types.each_value do |role_type|
  role_class = eval("#{role_type}Role")
  role_class.names.each_key { |role_name| role_class.get(role_name)}
end

# ======================================
# STATES
# ======================================
puts 'Loading States'
#TODO: move to YAML?
states = [
    {:abbrev => 'AL', :name => 'Alabama'},
    {:abbrev => 'AK', :name => 'Alaska'},
    {:abbrev => 'AZ', :name => 'Arizona'},
    {:abbrev => 'AL', :name => 'Alabama'},
    {:abbrev => 'AS', :name => 'Arkansas'},
    {:abbrev => 'CA', :name => 'California'},
    {:abbrev => 'CO', :name => 'Colorado'},
    {:abbrev => 'CT', :name => 'Connecticut'},
    {:abbrev => 'DE', :name => 'Delaware'},
    {:abbrev => 'DC', :name => 'District of Columbia'},
    {:abbrev => 'FL', :name => 'Florida'},
    {:abbrev => 'GA', :name => 'Georgia'},
    {:abbrev => 'HI', :name => 'Hawaii'},
    {:abbrev => 'ID', :name => 'Idaho'},
    {:abbrev => 'IL', :name => 'Illinois'},
    {:abbrev => 'IA', :name => 'Iowa'},
    {:abbrev => 'KS', :name => 'Kansas'},
    {:abbrev => 'KY', :name => 'Kentucky'},
    {:abbrev => 'LA', :name => 'Louisiana'},
    {:abbrev => 'ME', :name => 'Maine'},
    {:abbrev => 'MD', :name => 'Maryland'},
    {:abbrev => 'MA', :name => 'Massachusetts'},
    {:abbrev => 'MI', :name => 'Michigan'},
    {:abbrev => 'MN', :name => 'Minnesota'},
    {:abbrev => 'MS', :name => 'Mississippi'},
    {:abbrev => 'MO', :name => 'Missouri'},
    {:abbrev => 'MT', :name => 'Montana'},
    {:abbrev => 'NE', :name => 'Nebraska'},
    {:abbrev => 'NV', :name => 'Nevada'},
    {:abbrev => 'NH', :name => 'New Hampshire'},
    {:abbrev => 'NJ', :name => 'New Jersey'},
    {:abbrev => 'NM', :name => 'New Mexico'},
    {:abbrev => 'NY', :name => 'New York'},
    {:abbrev => 'NC', :name => 'North Carolina'},
    {:abbrev => 'ND', :name => 'North Dakota'},
    {:abbrev => 'OH', :name => 'Ohio'},
    {:abbrev => 'OK', :name => 'Oklahoma'},
    {:abbrev => 'OR', :name => 'Oregon'},
    {:abbrev => 'PA', :name => 'Pennsylvania'},
    {:abbrev => 'PR', :name => 'Puerto Rico'},
    {:abbrev => 'RI', :name => 'Rhode Island'},
    {:abbrev => 'SC', :name => 'South Carolina'},
    {:abbrev => 'SD', :name => 'South Dakota'},
    {:abbrev => 'TN', :name => 'Tennessee'},
    {:abbrev => 'TX', :name => 'Texas'},
    {:abbrev => 'UT', :name => 'Utah'},
    {:abbrev => 'VT', :name => 'Vermont'},
    {:abbrev => 'VI', :name => 'Virgin Islands'},
    {:abbrev => 'VA', :name => 'Virginia'},
    {:abbrev => 'WA', :name => 'Washington'},
    {:abbrev => 'WV', :name => 'West Virginia'},
    {:abbrev => 'WI', :name => 'Wisconsin'},
    {:abbrev => 'WY', :name => 'Wyoming'}]

  #TODO: provinces?

states.each do |s|
  s = State.create!(s.merge(:state_rep_id => 0))
end

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
  puts r[:name]
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
real_people = [
  {:first_name => 'David',   :last_name => 'Conner',    :email => 'dconner.pro@gmail.com', :birthday => '5/11/1986'},
  {:first_name => 'System',  :last_name => 'Admin',      :email => 'admin@somewebsite.com', :birthday => '12/21/2012'}
]

# verified, current_member, etc?

real_people.each do |person|
  member = Member.create!(person.merge(:password => 'password!'))
  member.roles << Role.get(:app_admin)
  member.save
end