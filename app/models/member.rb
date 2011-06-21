# MEMBERS MODEL ====================
# TODO: require address
# TODO: CHANGE TO SET A PASSWORD REGARDLESS OF FACEBOOK AUTH

# MEMBERS ==============================
# TODO: Override the super to pass addtional parameters to the model
# TODO: Implement nested form attributes for member address
# TODO: add a WSA MEMBER ID field
# TODO: Add WSA Membership ID field to members Model
# TODO: Add bio/about me


# ADMIN ===============================
# TODO: config options model
# TODO: create admin controller
# TODO: implement admin role

class Member < ActiveRecord::Base

  after_create :set_up_member

  has_many :authentications

  has_many :role_members
  has_many :roles, :through => :role_members

  has_one :address, :as => :addressable, :dependent => :destroy
  belongs_to :rink, :foreign_key => :homerink_id

  has_many :team_requests, :class_name => "TeamMember", :finder_sql =>
      'SELECT tm.* from team_members tm where (tm.requestor_id = #{id} or tm.member_id = #{id})'

  #this relationship does not list team members, it finds the member's active team record
  has_many :team_members, :class_name => "TeamMember", :finder_sql =>
      'SELECT tm.* from team_members tm where (tm.requestor_id = #{id} or tm.member_id = #{id}) and active = true'
  has_many :team_mates, :class_name => 'Member', :finder_sql =>
'SELECT team_mems.*
FROM members this_member
INNER JOIN team_members active_tm
  ON  (this_member.id = active_tm.member_id
  OR this_member.id = active_tm.requestor_id)
  AND active_tm.active = true
INNER JOIN teams t
  ON active_tm.team_id = t.id
INNER JOIN team_members tm
  ON t.id = tm.team_id
  AND tm.active = true
INNER JOIN members team_mems
  ON (team_mems.id = tm.requestor_id and t.creator_id = #{id})
  OR (team_mems.id = tm.member_id and t.creator_id != #{id})
WHERE this_member.id = #{id}
  AND team_mems.id != #{id}'

#    has_many :team_mates, :class_name => 'Member', :finder_sql =>
#'SELECT team_mems.*
#FROM members this_member
#INNER JOIN team_members active_tm
#  ON  (this_member.id = active_tm.member_id
#  OR this_member.id = active_tm.requestor_id)
#  AND active_tm.active = true
#INNER JOIN teams t
#  ON active_tm.team_id = t.id
#INNER JOIN team_members tm
#  ON t.id = tm.team_id
#  AND tm.active = true
#INNER JOIN members team_mems
#  ON (team_mems.id = tm.requestor_id and t.creator_id = #{id})
#  OR (team_mems.id = tm.member_id and t.creator_id != #{id})
#WHERE this_member.id = #{id}
#  AND team_mems.id != #{id}'

  has_many :pending_sent_team_requests, :class_name => "TeamMember", :foreign_key => "requestor_id",
           :conditions => '(approved = false and rejected = false)'
  has_many :pending_recd_team_requests, :class_name => "TeamMember", :foreign_key => "member_id",
           :conditions => '(approved = false and rejected = false)'
  has_many :pending_team_requests, :class_name => "TeamMember", :finder_sql =>
      'SELECT tm.* from team_members tm where (tm.requestor_id = #{id} or tm.member_id = #{id}) and (approved = false and rejected = false)'

  has_many :teams, :class_name => "Team", :finder_sql =>
      'SELECT t.* from teams t inner join team_members tm on t.id = tm.team_id where tm.active = true and tm.member_id = #{id}'
  has_many :history_teams, :class_name => "Team", :finder_sql =>
      'SELECT t.* from teams t inner join team_members tm on t.id = tm.team_id where tm.approved = true and tm.member_id = #{id}'

  has_one :owned_team, :class_name => "Team", :foreign_key => "creator_id"

  has_many :pending_sent_friend_requests, :class_name => 'Friendship', :foreign_key => 'member_id', :conditions => 'approved = false and rejected = false'
  has_many :pending_recd_friend_requests, :class_name => 'Friendship', :foreign_key => 'friend_id', :conditions => 'approved = false and rejected = false'

  has_many :friendships, :class_name => 'Friendship', :finder_sql =>
      'SELECT f.* from friendships f where (f.member_id = #{id} or f.friend_id = #{id}) and active = true'
  has_many :friends, :class_name => 'Member', :include => 'Member', :finder_sql =>
'SELECT m.*
from friendships f
INNER JOIN members m
    on (m.id = f.member_id and f.member_id != #{id})
    or (m.id = f.friend_id and f.friend_id != #{id})
where (f.member_id = #{id} or f.friend_id = #{id})
    and active = true;'


  
  accepts_nested_attributes_for :address

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  #     (add extra attributes here)
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name

  #========================================
  #  NAMED SCOPES
  #========================================
  

  #========================================
  #  Callbacks
  #========================================
  def set_up_member
    #set up basic roles
    role = Role.find_by_name('Member')
    role_member = RoleMember.new_of_type 'Admin'
    role_member.roleable_id = -1
    role_member.role = role

    Member.transaction do
      role_members << role_member
      save
    end
  end

  #========================================
  #  Devise/Omniauth Helpers
  #========================================
  def apply_omniauth(omniauth)
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end

  def role_symbols
    roles.map do |role|
      role.name.underscore.to_sym
    end
  end

  #========================================
  #  Member Helpers
  #========================================
  def full_name
    first_name.capitalize + ' ' + last_name.capitalize
  end

  #========================================
  #  Team Helpers
  #========================================
  def has_team
    teams.any?
  end

  #basically an aliased scope
  def team
    t = teams.first

    #if t then t else Team.new end
  end

  #if you have already requested the member
  def already_requested_by member
    pending_recd_team_requests.member_requests.sent_from(member).any?
  end

  #if you have already requested the team
  def already_requested_team team
    pending_sent_team_requests.team_requests.sent_to(team).any?
  end

  #if you have already requested the team
  def already_request_from_team team
    pending_recd_team_requests.member_requests.sent_to(team).any?
  end

  #========================================
  #  Friend Helpers
  #========================================
  def already_friend_request_from member
    pending_recd_friend_requests.sent_from(member).any?
  end

  def already_friend_request_to member
    pending_sent_friend_requests.sent_to(member).any?
  end

  def already_friends_with member
    friends.include? member
  end

  #========================================
  #  Role Helpers
  #========================================

#  def already_requested_test obj
#    if obj.class.name == 'Member'
#      return (pending_recd_team_requests.member_requests.sent_from(obj).any? or
#          pending_sent_team_requests.member_requests.r_to(obj).any?)
#    end
#    if obj.class.name == 'Team'
#      return (pending_recd_team_requests.member_requests.sent_to(obj).any? or
#          pending_sent_team_requests.member_requests.sent_to(obj).any?)
#    end
#  end

end
