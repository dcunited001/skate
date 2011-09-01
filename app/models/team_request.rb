class TeamRequest < ActiveRecord::Base
  belongs_to :member_requested, :class_name => 'Member'
  belongs_to :member_requesting, :class_name => 'Member'

  belongs_to :team

  scope :for_team, lambda { |team| where(:team_id => team.id) }
  scope :sent_from, lambda { |member| where(:member_requesting_id => member.id) }
  scope :sent_to,  lambda { |member| where(:member_requested_id => member.id) }

  scope :pending, where('active = ? and accepted = ? and rejected = ?', false, false, false)
  scope :active, where('active = ?', true)
  scope :accepted, where('accepted = ?', true)
  scope :rejected, where('accepted = ? and rejected = ?', false, true)
  scope :ended, where('accepted = ? and rejected = ?', true, true)

  scope :quit_team, where('accepted = ? and rejected = ? and kickoff_date is null', true, true)
  scope :kicked_off, where('accepted = ? and rejected = ? and kickoff_date is not null', true, true)

  # incoming/outgoing requests (from the team's perspective')
  scope :incoming, where('incoming = ?', true)
  scope :outgoing, where('incoming = ?', false)

  class << self
    alias_method :to_team, :incoming
    alias_method :from_team, :outgoing
  end
end
