Factory.define(:member, :class => 'Member') do |member|
  member.first_name 'Normal'
  member.sequence(:last_name) {|n| "User#{n}"}
  member.sequence(:alias) {|n| "normaluser#{n}"}
  member.sequence(:email) {|n| "email#{n}@example.org"}
  member.password 'password'
  member.password_confirmation 'password'

  member.birthday random_date(1985, 10)
  member.phone random_phone

  member.rink_id -1

  member.address {|m| m.association(:address)}
end

Factory.define(:admin, :parent => :member) do |member|
  member.first_name 'Admin'
  member.sequence(:alias) {|n| "adminuser#{n}"}

  member.after_create do |m|
    m.assign_role(:appadmin)
  end
end

Factory.define(:private_member, :parent => :member) do |member|
  member.first_name 'Private'
  member.sequence(:alias) {|n| "privateuser#{n}"}

  #pseudocode
  #member.privacy_settings.visibility = PrivacySettings::PRIVATE_VISIBILITY
end

# I'm really not sure if these will work, with the roles that need to be added
# might be better to add some helpers to create the objects

# ugh complicated

#Factory.define(:team_member, :parent => :member) do |member|
#  member.first_name 'Teammember'
#  member.sequence(:alias) {|n| "teammember#{n}"}
#
#  member.team {|m| m.association(:team)}
#
#  member.after_create do |m|
#    m.assign_role(:teammember, m.team)
#  end
#end
#
#Factory.define(:team_creator, :parent => :member) do |member|
#  member.first_name 'Teamcreator'
#  member.sequence(:alias) {|n| "teamcreator#{n}"}
#
#  member.team {|m| m.association(:team, :creator => m)}
#
#  member.after_create do |m|
#    m.assign_role(:teamcreator, m.team)
#  end
#end
