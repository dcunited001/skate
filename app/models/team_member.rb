class TeamMember < ActiveRecord::Base
  belongs_to :team
  belongs_to :member
  belongs_to :requestor, :class_name => "Member"

  #NAMED SCOPES
#  scope :team_requests, lambda { |member|
#    joins(:teams).
#  }
#        where("member_id = requestor_id")
  scope :team_requests, where("member_id = requestor_id")
  scope :member_requests, where("member_id != requestor_id")

  scope :sent_from, lambda {|member| where(:requestor_id => member.id)}
  #scope :received_from, lambda {|member| where(:member_id => member.id)}
  scope :sent_to, lambda {|team| where(:team_id => team.id)}
  #scope :sent_to_team, lambda {|team| where(:team_id => team.id)}

  scope :requests_for_team, lambda {|team| where(:team_id => team.id)}

  scope :current, where("active = 1")
  scope :waiting_for_approval, where("approved = 0 and rejected = 0")
  scope :joined_teams, where("approved = 1")
  scope :rejected_teams, where("rejected = 1")

  validate :not_already_on_team,
           :not_already_requested_by,
           :not_already_requested_team,
           :not_already_request_from_team

  validates_presence_of :member
  validates_presence_of :requestor

  def not_already_on_team
    errors.add(:already_on_team, 'Already on a Team') if
        member.team
  end

  def not_already_requested_by
    errors.add(:already_on_team, 'Already Requested') if
        member.already_requested_by requestor
  end

  def not_already_requested_team
    errors.add(:already_requested_team, 'Already Requested this Team') if
        member.already_requested_team team
  end

  def not_already_request_from_team
    errors.add(:already_requested_team, 'Already Requested this Member') if
        member.already_request_from_team team
  end
end




#  scope :basic, lambda {
#    joins(:role_members).
#    where("role_members.roleable_type = 'Admin'")
#  }