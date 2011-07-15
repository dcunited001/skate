class Member < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #for omniauth
  #has_many :authentications

  include Rollable::Base
  rollables :team, :rink,
    :roles => Role.all_role_names,
    :allow_nil => true

  has_one :address, :as => :addressable, :dependent => :destroy
  belongs_to :rink, :foreign_key => :homerink_id

  has_many :friend_requests_recd, :class_name => 'Friendship', :foreign_key => 'member_requested_id'
  has_many :friend_requests_sent, :class_name => 'Friendship', :foreign_key => 'member_requesting_id'
  has_many :friends # Don't need this anymore ===> :class_name => 'Friend', :finder_sql => "Select * from v_friends"

  has_many :team_requests_recd, :class_name => 'TeamRequest', :foreign_key => 'member_requested_id'
  has_many :team_requests_sent, :class_name => 'TeamRequest', :foreign_key => 'member_requesting_id'
  #has_many :team_members, :finder_sql => 'select * from view'

  validates_presence_of :first_name, :last_name

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name
  accepts_nested_attributes_for :address

  after_create :add_basic_member_role

  #========================================
  #  Role Helpers
  #========================================
  def add_basic_member_role
    roles.create(:name => 'appuser')
  end

  def assign_role(role, *args)
    target = args.first.presence
    role = (role.to_s if role.is_a?(Symbol))
    roles.create!(:name => role, :rollable => target)
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

  #========================================
  #  Rink Helpers
  #========================================
  def has_rink?
    (homerink_id > 0)
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
  def already_team_request_from? team, member
    true
  end

  def already_team_request_to? team, member
    true
  end

  def already_on_team? team
    true
  end

  def team_requestable? team, member
    !(already_friend_request_from?(team, member) || already_friend_request_to?(team, member) || already_on_team?(team))
  end
end
