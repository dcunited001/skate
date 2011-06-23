# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# ======================================
# ROLES
# ======================================
puts 'Creating Roles'
Role.names.keys.each do |r|
  Role.get(r)
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
# TODO: load rinks from YAML
puts 'Creating Rinks'
rinks_yml = YAML::load_file(File.join(Rails.root, 'db/seeds','rinks.yml'))
rinks_yml.keys.each {|k|
  puts "#{k}: #{rinks_yml[k]['name']}"
  Rink.create!(rinks_yml[k])
}

#TODO: Store lat and long with addresses to avoid Geocode Calls!!
puts 'Rinks Created'
puts '  (run `rake addresses:geocode` to geocode'


#seed_file = File.join(Rails.root, 'db', 'seed.yml')
#config = YAML::load_file(seed_file)
#User.create(config["users"])
#Category.create(config["categories"])
#Product.create(config["products"])

# default rink in easter island (default address)




# ======================================
# ADDRESSES
# ======================================
# TODO: load addresses from YAML
# or could they be nested in the rink's and team's yamls??
# how to match states and regions?

# ======================================
# MEMBERS
# ======================================
# TODO: hard code basic admin users
# TODO: hard code basic manager users
puts 'Creating Admin Accounts'
real_people = [
  {:first_name => 'David',   :last_name => 'Conner',    :email => 'dconner.pro@gmail.com', :birthday => '5/11/1986'},
  {:first_name => 'System',  :last_name => 'Admin',      :email => 'admin@wsajam.com', :birthday => '12/21/2012'}
]

# verified, current_member, etc?

real_people.each do |person|
  member = Member.create!(person.merge(:password => 'password!'))
  member.roles << Role.get(:admin)
  member.roles << Role.get(:member)
  member.save
end

#
## EXAMPLES !!!!!!!!!!
#
#puts "Creating Shirt Sizes"
#['Youth Small',
# 'Youth Medium',
# 'Youth Large',
# 'Youth XL',
# 'Adult Medium',
# 'Adult Large',
# 'Adult XL',
# 'Adult XXL',
# 'Adult XXXL'].each do |size|
#  ShirtSize.create!(:label => size)
#end
#
#
#puts "Creating Grades"
#(['Preschool', 'K'] + (1..9).to_a).each do |grade|
#  grade = Grade.create!(:label => grade.is_a?(Fixnum) ? grade.ordinalize : grade)
#  puts "Created '#{grade.label}'."
#end
#
#
#puts "Creating Organizations"
#organization = Organization.create!(:name => 'Bay-Area Flag Football', :hostname => 'bay-area', :default => true)
#other_organization = Organization.create!(:name => 'Virginia Beach Flag Football', :hostname => 'virginia-beach', :default => false)
#
#puts "Creating Schools"
#schools = [{:name => "Sierramont Middle School", :city => "San Jose"},
#           {:name => "Martin Luther King, Jr Middle School", :city => "Berkeley"},
#           {:name => "California School for the Deaf", :city => "Fremont"},
#           {:name => "Sunol Glen School", :city => "Sunol"},
#           {:name => "Luther Burbank School District", :city => "San Jose"},
#           {:name => "Claire Lilienthal School", :city => "San Francisco"},
#           {:name => "Phillips-Edison Partnership School", :city => "Napa"},
#           {:name => "Hopkins Junior High School", :city => "Fremont"},
#           {:name => "Creekside Middle School", :city => "Rohnert Park"},
#           {:name => "River Glen K-8", :city => "San Jose"},
#           {:name => "Pleasanton Middle School", :city => "Pleasanton"},
#           {:name => "Union Middle School", :city => "San Jose"},
#           {:name => "McKinley Middle School", :city => "Redwood City"},
#           {:name => "Stone Valley Middle School", :city => "Alamo"},
#           {:name => "Junction Avenue Middle School", :city => "Livermore"},
#           {:name => "Miller Middle School", :city => "San Jose"},
#           {:name => "César Chávez Middle School", :city => "Union City"},
#           {:name => "Central Middle School", :city => "San Carlos"},
#           {:name => "Alvarado Middle School", :city => "Union City"},
#           {:name => "Jordan Middle School", :city => "Palo Alto"},
#           {:name => "Allen at Steinbeck", :city => "San Jose"},
#           {:name => "Benicia Middle School", :city => "Benicia"},
#           {:name => "Chaboya Middle School", :city => "San Jose"},
#           {:name => "Potrero Hill Middle School", :city => "San Francisco"},
#           {:name => "Hillcrest Middle School", :city => "Sebastopol"},
#           {:name => "John Muir Middle School", :city => "San Jose"},
#           {:name => "Quimby Oak Middle School", :city => "San Jose"},
#           {:name => "Charlotte Wood Middle School", :city => "Danville"},
#           {:name => "Walnut Creek Intermediate School", :city => "Walnut Creek"},
#           {:name => "Harvest Park Middle School", :city => "Pleasanton"},
#           {:name => "Burnett Middle School", :city => "San Jose"},
#           {:name => "Diablo View Middle School", :city => "Clayton"},
#           {:name => "Castillero Middle School", :city => "San Jose"},
#           {:name => "Hoover Middle School", :city => "San Jose"},
#           {:name => "Joaquin Miller Middle School", :city => "Cupertino"},
#           {:name => "Los Cerros Middle School", :city => "Danville"},
#           {:name => "Terrace Middle School", :city => "Lakeport"},
#           {:name => "Willow Glen Middle School", :city => "San Jose"},
#           {:name => "LeyVa Middle School", :city => "San Jose"},
#           {:name => "Redwood City Middle Schools Annual Grand Canyon Trek", :city => "Redwood City"},
#           {:name => "Jane Lathrop Standford Middle School", :city => "Palo Alto"},
#           {:name => "Joaquin Moraga Intermediate School", :city => "Moraga"},
#           {:name => "Borel Middle School", :city => "San Mateo"},
#           {:name => "Bayside Middle School for the Arts and Creative Technology", :city => "San Mateo"},
#           {:name => "Dartmouth Middle School", :city => "San Jose"},
#           {:name => "Bret Harte Middle School", :city => "San Jose"},
#           {:name => "C.A. Jacobs Intermediate School", :city => "Dixon"},
#           {:name => "Morrill Middle School", :city => "San Jose"},
#           {:name => "Stanley Middle School", :city => "Lafayette"}]
#schools.each do |school|
#  organization.schools << School.create(school)
#end
#
#
#puts "Creating Schools"
#schools = [{:name => "Diamond Springs Elementary", :city => "Virginia Beach"},
#           {:name => "Corporate Landing Middle", :city => "Virginia Beach"},
#           {:name => "Cox High", :city => "Virginia Beach"}]
#schools.each do |school|
#  other_organization.schools << School.create(school)
#end
#
#puts "Creating SF Leagues"
#leagues = ['Campbell / Los Gatos',
#             'Cupertino / Sunnyvale',
#             'Dublin',
#             'Marin',
#             'Mountain View / Los Altos',
#             'Palo Alto',
#             'San Jose: Almaden',
#             'San Jose: Berryessa',
#             'San Jose: Cambrian',
#             'San Jose: Evergreen',
#             'San Jose: Oak Grove',
#             'San Jose: Willow Glen',
#             'Santa Clara',
#             'Saratoga']
#leagues.each do |league|
#  puts "  Creating #{league}"
#  league = League.create!(:name => league, :organization => organization, :fee => 125)
#
#  puts "    Creating Divisions"
#  Division.create!(:name => 'Division A',
#                  :age_range_start => 4,
#                  :age_range_end => 5,
#                  :league_id => league.id)
#  Division.create!(:name => 'Division B',
#                  :age_range_start => 6,
#                  :age_range_end => 7,
#                  :league_id => league.id)
#  Division.create!(:name => 'Division C',
#                  :age_range_start => 8,
#                  :age_range_end => 9,
#                  :league_id => league.id)
#  Division.create!(:name => 'Division D',
#                  :age_range_start => 10,
#                  :age_range_end => 11,
#                  :league_id => league.id)
#  Division.create!(:name => 'Division E',
#                  :age_range_start => 12,
#                  :age_range_end => 13,
#                  :league_id => league.id)
#  Division.create!(:name => 'Division F',
#                  :age_range_start => 14,
#                  :age_range_end => 15,
#                  :league_id => league.id)
#
#  puts "    Creating Seasons"
#  Season.create!(:name => 'Fall 2010',
#                 :league_id => league.id,
#                 :age_cutoff_date => Date.new(2010, 8, 15),
#                 :registration_begins_at => Date.new(2010, 8, 15),
#                 :registration_ends_at => Date.new(2010, 8, 31),
#                 :start_date => Date.new(2010, 9, 10),
#                 :end_date => Date.new(2010, 11, 30) )
#  Season.create!(:name => 'Spring 2011',
#                 :league_id => league.id,
#                 :age_cutoff_date => Date.new(2011, 2, 1),
#                 :registration_begins_at => Date.new(2011, 2, 1),
#                 :registration_ends_at => Date.new(2011, 2, 15),
#                 :start_date => Date.new(2011, 3, 1),
#                 :end_date => Date.new(2011, 6, 30) )
#  Season.create!(:name => 'Fall 2011',
#                 :league_id => league.id,
#                 :age_cutoff_date => Date.new(2011, 8, 15),
#                 :registration_begins_at => Date.new(2011, 8, 15),
#                 :registration_ends_at => Date.new(2011, 8, 31),
#                 :start_date => Date.new(2011, 9, 10),
#                 :end_date => Date.new(2011, 11, 30) )
#  Season.create!(:name => 'Spring 2012',
#                 :league_id => league.id,
#                 :age_cutoff_date => Date.new(2012, 2, 1),
#                 :registration_begins_at => Date.new(2012, 2, 1),
#                 :registration_ends_at => Date.new(2012, 2, 15),
#                 :start_date => Date.new(2012, 3, 1),
#                 :end_date => Date.new(2012, 6, 30) )
#  Season.create!(:name => 'Fall 2012',
#                 :league_id => league.id,
#                 :age_cutoff_date => Date.new(2012, 8, 15),
#                 :registration_begins_at => Date.new(2012, 8, 15),
#                 :registration_ends_at => Date.new(2012, 8, 31),
#                 :start_date => Date.new(2012, 9, 10),
#                 :end_date => Date.new(2012, 11, 30) )
#  Season.create!(:name => 'Current Season',
#                 :league_id => league.id,
#                 :age_cutoff_date => 1.week.from_now,
#                 :registration_begins_at => 1.week.ago,
#                 :registration_ends_at => 1.week.from_now,
#                 :start_date => 1.month.from_now,
#                 :end_date => 5.months.from_now )
#
#end
#
#
#
#
#
#puts 'Creating Default Admin Accounts'
#
#real_people = [
#  {:first_name => 'John',    :last_name => 'Mora',       :email => 'john.mora@playflagfootball.com'},
#  {:first_name => 'Brennan', :last_name => 'Dunn',       :email => 'brennan.dunn@wearetitans.net'},
#  {:first_name => 'Geoff',   :last_name => 'Parsons',    :email => 'geoff.parsons@wearetitans.net'},
#  {:first_name => 'Andrew',  :last_name => 'Culver',     :email => 'andrew.culver@gmail.com'},
#  {:first_name => 'Thomas',  :last_name => 'Symborski',  :email => 'thomas.symborski@wearetitans.net'},
#  {:first_name => 'Kristi',  :last_name => 'Dunlap',     :email => 'kdunlap@wearetitans.net'},
#  {:first_name => 'Zack',    :last_name => 'Miller',     :email => 'zack.miller@wearetitans.net'},
#  {:first_name => 'Joe',     :last_name => 'DelCioppio', :email => 'joe@wearetitans.net'},
#  {:first_name => 'Blake',   :last_name => 'Imsland',    :email => 'blake@retroco.de'},
#  {:first_name => 'System',  :last_name => 'Admin',      :email => 'system.admin@playflagfootball.com'},
#]
#
#real_people.each do |person|
#  user = User.create!(person.merge(:password => 'password!'))
#  user.roles << Role.get(:system_admin)
#  user.save
#end
#
#
#puts 'Creating Example Accounts'
#
#role_names = [:admin, :commissioner, :member, :parent, :coach]
#
#[organization, other_organization].each do |org|
#  role_names.each do |role|
#    role = Role.get(role)
#
#    person = {
#      :organization_id => org.id,
#      :first_name      => org.name,
#      :last_name       => role.name,
#      :email           => "#{org.hostname.downcase}.#{role.name.downcase}@playflagfootball.com",
#      :password        => 'password!',
#    }
#
#    puts " - #{role.name} for #{org.name} is #{person[:email]}"
#
#    user = User.create!(person)
#    user.roles << role
#    user.save
#  end
#end
#
#puts "Adding Palo Alto as the league that the commissioner can admin"
#
#commissioner = User.find_by_email("bay-area.commissioner@playflagfootball.com")
#commissioner.leagues << League.find_by_name("Palo Alto")
#commissioner.save
#
#
#
