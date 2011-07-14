class Member < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #for omniauth
  #has_many :authentications

  #has_many :role_members
  #has_many :roles, :through => :role_members

  include Rollable::Base
  rollables :team, :rink,
    :roles => Role.all_role_names,
    :allow_nil => true

  has_one :address, :as => :addressable, :dependent => :destroy
  belongs_to :rink, :foreign_key => :homerink_id

  has_many :friend_requests_recd, :class_name => 'Friendship', :foreign_key => 'member_requested_id'
  has_many :friend_requests_sent, :class_name => 'Friendship', :foreign_key => 'member_requesting_id'
  #has_many :friends, :class_name => 'Friendship', :finder_sql => 'select * from view'

  has_many :team_requests_recd, :class_name => 'TeamMember', :foreign_key => 'member_requested_id'
  has_many :team_requests_sent, :class_name => 'TeamMember', :foreign_key => 'member_requesting_id'
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

  #========================================
  #  Formatting Helpers
  #========================================
  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  #========================================
  #  Friend Helpers
  #========================================


  #========================================
  #  Rink Helpers
  #========================================
  def has_rink?
    (homerink_id > 0)
  end
end
