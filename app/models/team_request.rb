class TeamRequest < ActiveRecord::Base
  belongs_to :member_requested, :class_name => 'Member'
  belongs_to :member_requesting, :class_name => 'Member'

  belongs_to :team

  scope :for_team, lambda { |team| where(:team_id => team.id) }

  scope :sent_from, lambda { |member| where(:member_requesting_id => member.id) }
  scope :sent_to,  lambda { |member| where(:member_requested_id => member.id) }




  # incoming/outgoing requests (from the team's perspective')
  scope :incoming, where('incoming = ?', true)
  scope :outgoing, where('incoming = ?', false)

  alias_method :to_team, :incoming
  alias_method :from_team, :outgoing
end
