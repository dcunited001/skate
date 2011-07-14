Factory.define(:friendship, :class => 'Friendship') do |friendship|
  friendship.association :member_requested
  friendship.association :member_requesting
end

Factory.define(:friend, :parent => :friendship) do |friend|
  friend.active true
  friend.approved true
end

Factory.define(:rejected_friendship, :parent => :friendship) do |friendship|
  friendship.rejected true
end

Factory.define(:ended_friendship, :parent => :friendship) do |friendship|
  friendship.approved true
  friendship.rejected true
end


