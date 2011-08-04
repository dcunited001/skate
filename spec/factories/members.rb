Factory.define(:member, :class => 'Member') do |member|
  member.first_name 'Normal'
  member.sequence(:last_name) {|n| "User#{n}"}
  member.sequence(:alias) {|n| "normaluser#{n}"}
  member.sequence(:email) {|n| "email#{n}@example.org"}
  member.password 'password'
  member.password_confirmation 'password'

  member.birthday random_date(1985, 10)
  member.phone random_phone

  member.homerink_id -1

  member.address {|m| m.association(:address)}
end

Factory.define(:admin, :parent => :member) do |member|
  member.first_name 'Admin'

  member.after_create do |m|
    m.assign_role(:appadmin)
  end
end

Factory.define(:private_member, :parent => :member) do |member|
  #pseudocode
  #member.privacy_settings.visibility = PrivacySettings::PRIVATE_VISIBILITY
end
