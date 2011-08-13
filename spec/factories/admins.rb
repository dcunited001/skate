Factory.define(:admin, :class => 'Admin') do |member|
  member.first_name 'Admin'
  member.sequence(:alias) {|n| "adminuser#{n}"}

  member.sequence(:last_name) {|n| "User#{n}"}
  member.sequence(:email) {|n| "email#{n}@example.org"}
  member.password 'password'
  member.password_confirmation 'password'

  member.birthday random_date(1985, 10)
  member.phone random_phone

  member.rink_id -1

  member.address {|m| m.association(:address)}
end