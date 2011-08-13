Factory.define(:team_request, :class => 'TeamRequest') do |team_request|
  team_request.association :team
  team_request.association :member_requesting
  team_request.association :member_requested
  team_request.incoming false
end

Factory.define(:team_request_from, :parent => :team_request) do |team_request|
  team_request.incoming true
end

Factory.define(:team_member, :parent => :team_request) do |team_request|
  team_request.approved true
  team_request.active true
end

Factory.define(:team_member_from, :parent => :team_member) do |team_request|
  team_request.incoming true
end

Factory.define(:rejected_team_request, :parent => :team_request) do |team_request|
  team_request.rejected true
end

Factory.define(:ended_team_membership, :parent => :team_request) do |team_request|
  team_request.rejected true
  team_request.approved true
end