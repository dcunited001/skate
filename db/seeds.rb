# ======================================
# STATES
# ======================================
puts 'Loading States'
State.load_from_yaml

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

northeast.states << State.where(:abbrev => %w(ME VT NH MA RI NY PA MD DE DC WV VA))
southeast.states << State.where(:abbrev => %w(TN NC SC GA MS AL FL))
greatlakes.states << State.where(:abbrev => %w(OH KY IL IN MI WI MO))
midwest.states << State.where(:abbrev => %w(IA MN ND SD MT WY CO UT))
northwest.states << State.where(:abbrev => %w(WA ID OR AK))
southwest.states << State.where(:abbrev => %w(CA AZ NV HI))
southcentral.states << State.where(:abbrev => %w(AS LA TX OK KS NM))

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
    rink.visible = true
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
puts 'Creating Admin Accounts'
admins = [
  {:first_name => 'David',   :last_name => 'Conner', :alias => 'dconner', :email => 'dconner.pro@gmail.com', :birthday => '5/11/1986'},
  {:first_name => 'System',  :last_name => 'Admin', :alias => 'admin', :email => 'admin@somewebsite.com', :birthday => '21/12/1969'}]

#OG Addy
og_addy = {
    :line_one => '123 OG Cruise',
    :city => 'Los Angeles',
    :state => 'CA',
    :zip => '90013'
}

admins.each do |person|
  member = Member.create!(person.merge(:password => 'password!'))
  member.address = Address.create!(og_addy)
  member.assign_role(:appadmin)
end

puts 'Creating Some Member Accounts'
og_member = Factory(:member)
member_sent_request_by_subject_one = Factory(:member)
member_sent_request_by_subject_two = Factory(:member)
member_sent_request_by_another_member = Factory(:member)
member_sent_request_to_another_member = Factory(:member)
member_sent_request_to_subject = Factory(:member)
member_sent_no_requests = Factory(:member)

friend_member_sent_by_subject = Factory(:member)
friend_member_sent_to_subject = Factory(:member)
member_not_friends_anymore = Factory(:member)

# ======================================
# FRIENDS AND FRIENDSHIPS
# ======================================
puts 'Creating Some Friend Requests and Friends as a Starting Point'
request_sent_by_subject_one = Factory(:friendship, :member_requesting => og_member, :member_requested => member_sent_request_by_subject_one)
request_sent_by_subject_two = Factory(:friendship, :member_requesting => og_member, :member_requested => member_sent_request_by_subject_two)

request_sent_to_another_member = Factory(:friendship, :member_requesting => member_sent_request_to_another_member, :member_requested => member_sent_request_by_subject_two)
request_sent_to_another_member_two = Factory(:friendship, :member_requesting => member_sent_request_by_subject_one, :member_requested => member_sent_request_by_subject_two)
request_sent_to_subject = Factory(:friendship, :member_requesting => member_sent_request_to_subject, :member_requested => og_member)

friend_sent_by_subject = Factory(:friend, :member_requesting => og_member , :member_requested => friend_member_sent_by_subject)
friend_sent_to_subject = Factory(:friend, :member_requesting => friend_member_sent_to_subject , :member_requested => og_member)
not_friends_anymore = Factory(:friend, :member_requesting => member_not_friends_anymore , :member_requested => og_member, :rejected => true, :active => false)

#more friends
Factory(:friend, :member_requesting => og_member, :member_requested => Factory(:member))
Factory(:friend, :member_requesting => og_member, :member_requested => Factory(:member))
Factory(:friend, :member_requesting => og_member, :member_requested => Factory(:member))
Factory(:friend, :member_requesting => Factory(:member), :member_requested => og_member)
Factory(:friend, :member_requesting => Factory(:member), :member_requested => og_member)

Factory(:friend, :member_requesting => member_not_friends_anymore, :member_requested => Factory(:member))
Factory(:friend, :member_requesting => Factory(:member), :member_requested => member_not_friends_anymore)
Factory(:friend, :member_requesting => Factory(:member), :member_requested => member_not_friends_anymore)

Factory(:friend, :member_requesting => member_sent_request_to_subject, :member_requested => Factory(:member))
Factory(:friend, :member_requesting => member_sent_request_to_subject, :member_requested => Factory(:member))
Factory(:friend, :member_requesting => Factory(:member), :member_requested => member_sent_request_to_subject)
Factory(:friend, :member_requesting => Factory(:member), :member_requested => member_sent_request_to_subject)

# ======================================
# TEAMS
# ======================================
puts 'Creating some members for teams'

#jammers-va
dcunited = Factory(:member, :alias => 'dcunited001')
xm_jester_mx = Factory(:member, :alias => 'xm-Jester-mx')
cooper = Factory(:member, :alias => 'cory-coopster')

beef_jerky = Factory(:member, :alias => 'beef_jerky')
shannon = Factory(:member, :alias => 'breaksk8master')

dennis_gk = Factory(:member, :alias => 'dennis-gk')
ballentine = Factory(:member, :alias => 'ballentine')

quinton = Factory(:member, :alias => 'quinton')
james = Factory(:member, :alias => 'anaconda')

puts 'Creating Some Teams'
jammers_va = Factory(:team, :name => 'Jammers VA', :creator => dcunited)
breaksk8 = Factory(:team, :name => 'Breaksk8', :creator => shannon)
phase_two = Factory(:team, :name => 'Phase Two', :creator => dennis_gk)
authentic = Factory(:team, :name => 'Authentic Freaks', :creator => james)

# ======================================
# TEAM MEMBERS
# ======================================







