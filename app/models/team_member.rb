class TeamMember < ActiveRecord::Base
  belongs_to :member_requested, :class_name => 'Member'
  belongs_to :member_requesting, :class_name => 'Member'

  belongs_to :team
end
