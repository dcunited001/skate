Factory.define(:announcement, :class => 'Announcement') do |announcement|
  announcement.message lorem
  announcement.posted_by { |a| a.association(:member) }
  announcement.active true
  announcement.remain_posted_until 1.week.from_now
end

Factory.define(:inactive_announcement, :parent => :announcement) do |a|
  a.active false
end

Factory.define(:expired_announcement, :parent => :announcement) do |a|
  a.remain_posted_until 1.week.ago
end