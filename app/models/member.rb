class Member < ActiveRecord::Base
  #for omniauth
  #has_many :authentications

  include Rollable::Base
  rollables :team, :rink,
    :roles => Role.all_role_names,
    :allow_nil => true

  has_one :address, :as => :addressable, :dependent => :destroy
  belongs_to :rink

  has_many :friends     #view_friends
  has_many :friend_requests_recd, :class_name => Friendship, :foreign_key => 'member_requested_id'
  has_many :friend_requests_sent, :class_name => Friendship, :foreign_key => 'member_requesting_id'

  #has_one :team  #or has_many :teams with current_team method?
  has_many :teams, :class_name => MemberTeam
  has_many :team_mates  #view_team_mates
  has_many :team_requests_recd, :class_name => TeamRequest, :foreign_key => 'member_requested_id'
  has_many :team_requests_sent, :class_name => TeamRequest, :foreign_key => 'member_requesting_id'

  validates_presence_of :first_name, :last_name, :birthday, :alias
  validates_uniqueness_of :alias

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :phone, :birthday, :alias, :address, :address_attributes
  accepts_nested_attributes_for :address

  after_create :add_appuser_role

  #========================================
  #  Devise Configuration
  #========================================
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
          # Include default devise modules. Others available are:
          # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable

  #========================================
  #  Role Helpers
  #========================================
  def add_appuser_role
    assign_role(:appuser)
  end

  def assign_role(role, *args)
    target = args.first.presence
    role = (role.to_s if role.is_a?(Symbol))
    roles.create!(:name => role, :rollable => target)
  end

  def remove_role(role, *args)
    target = args.first.presence

    #target is nil when appropriate
    role = Role.where(:name => role, :member_id => self.id, :rollable => target).first
    role.delete
  end

  #========================================
  #  Privacy Helpers
  #========================================
  # the best place for these privacy constant might actually be the privacy settings model, when i come to cross that bridge
  PRIVACY_FULL_NAME = 'full_name'
  PRIVACY_FIRST_NAME = 'first_name'
  PRIVACY_NO_NAME = 'no_name'

  def set_privacy_visibility
    #pending
    false
  end

  def name
    name_privacy = PRIVACY_FULL_NAME

    case name_privacy
      when PRIVACY_FULL_NAME
        full_name
      when PRIVACY_FIRST_NAME
        first_name
      when PRIVACY_NO_NAME
        PRIVACY_NO_NAME
    end
  end

  #member.is_owner_of?(horse) # => true
  #user.is_owner(horse)
  #user.is_admin?
  #target_model.has_admin?
  #target_model.get_admins

  #========================================
  #  Formatting Helpers
  #========================================
  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  #========================================
  #  Friend Helpers
  #========================================
  def already_friend_request_from? member
    friend_requests_recd.sent_from(member).any?
  end

  def already_friend_request_to? member
    friend_requests_sent.sent_to(member).any?
  end

  def already_friends_with? member
    friends.include? member  #need to override equals method?
  end

  def friend_requestable? member
    !(already_friends_with?(member) || already_friend_request_to?(member) || already_friend_request_from?(member))
  end

  def mutually_friends_with? member, through_member
    false
  end

  # WHY YOU NO WORKING!!
  def add_to_friends member
    new_friend = Friend.new(:member_id => self, :id => member).save

    #self.friends << new_friend
  end

  # WHY YOU NO WORKING!!
  # a.friends << (b.to_friend(a))  #really wish i could reduce the syntax here
  # not sure how to override the collection method << for a specific model
  def to_friend member
    Friend.new(:member_id => self, :id => member)
  end

  #========================================
  #  Rink Helpers
  #========================================
  def has_rink?
    (rink_id > 0)
  end

  #========================================
  #  Team Helpers
  #========================================
  def has_team?
    false
  end

  #========================================
  #  Team Request Helpers
  #========================================
  def already_team_request_from? *args
    team, member = nil, nil
    args.each do |a|
      team = a if a.is_a? Team
      member = a if a.is_a? Member
    end

    if (team and member)
      false #already_team_request_from? team, member
    elsif (team)
      false #already_team_request_from? team
    elsif (member)
      false #already_team_request_from? member
    else
      false
      raise "invalid input exception, already_team_request_from? requires a member or a team"
    end
  end

  def already_team_request_to? *args
    team, member = nil, nil
    args.each do |a|
      team = a if a.is_a? Team
      member = a if a.is_a? Member
    end

    if (team and member)
      false #already_team_request_to? team, member
    elsif (team)
      false #already_team_request_to? team
    elsif (member)
      false #already_team_request_to? member
    else
      false
      raise "invalid input exception, already_team_request_to? requires a member or a team"
    end
  end

  def already_on_team? team
    false
  end

  def team_requestable? team, member
    false

    #!(already_friend_request_from?(team, member) || already_friend_request_to?(team, member) || already_on_team?(team))
  end
end


#for ice javascript templates
#class MemberCube < Ice::BaseCube
#
#end