Factory.define(:team, :class => 'Team') do |team|
  team.sequence(:name) { |n| "Team #{n}" }
  team.creator {|t| t.association(:member)}

  team.rink {|t| t.association(:rink)}
  team.address {|t| t.association(:address)}
end

