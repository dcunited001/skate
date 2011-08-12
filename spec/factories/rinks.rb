Factory.define(:rink, :class => 'Rink') do |rink|
  rink.sequence(:name) { |n| "Skateland #{n}"}
  rink.address { |r| r.association(:address) }

  rink.phone random_phone
  rink.sequence(:website) { |n| "www.rink-#{n}.com"}
  rink.email { |r| "rink-email@#{r.website}"}

  rink.visible true

  rink.description lorem
end

Factory.define(:invisible_rink,:parent => :rink) do |rink|
  rink.visible false
end

Factory.define(:contacted_rink, :parent => :rink) do |rink|
  rink.contacted true
  rink.original_contact_date random_date(2010, 2)
  rink.last_contact_date { |r| r.original_verified_date }

  rink.contact_name "billy_bob"
  rink.owner_name "billy bobert"

  rink.allow_comments false
end

Factory.define(:verified_rink, :parent => :contacted_rink) do |rink|
  rink.verified true
  rink.original_verified_date { |r| 1.months_since(r.last_contact_date) }
  rink.last_verified_date { |r| r.original_verified_date }

  rink.allow_comments true
end

Factory.define(:registered_rink, :parent => :verified_rink) do |rink|
  rink.register_date { |r| 1.months_since(r.last_verified_date) }
end

Factory.define(:sanctioned_rink, :parent => :registered_rink) do |rink|
  rink.sanctioned true
  rink.original_sanction_date { |r| 1.months_since(r.register_date) }
  rink.last_sanction_date { |r| r.original_sanction_date }
end

#Factory.define(:rink_with_users, :parent => :sanctioned_rink) do |rink|
#  rink.owner { Factory.next(:rink_owner_user) }  #???
#  rink.Contact { Factory.next(:rink_owner_user) } #???
#end

#    t.string   "owner_name"
#    t.integer  "owner_id",  :default => -1

#    t.boolean "contacted"
#    t.datetime "original_contact_date"
#    t.datetime "last_contact_date"
#    t.string   "contact_name"
#    t.integer  "contact_id",  :default => -1
