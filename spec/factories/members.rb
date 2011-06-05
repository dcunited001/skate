
Factory.define(:member, :class => 'Member') do |member|
  member.first_name 'Normal'
  member.sequence(:last_name) {|n| "User #{n}"}
  member.sequence(:email) {|n| "email#{n}@example.org"}
  member.password 'password'
  member.password_confirmation 'password'

  member.birthday random_date(1985, 10)
  member.phone random_phone

  member.homerink_id -1

  member.address {|m| m.association(:address)}

  member.after_create do |m|
    m.roles << Role.get(:member)
  end
end

Factory.define(:admin, :parent => :member) do |member|
  member.first_name 'Admin'

  member.after_create do |m|
    m.roles << Roles.get(:admin)
  end
end

