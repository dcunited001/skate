class Team < ActiveRecord::Base
  has_one :address, :as => :addressable, :dependent => :destroy

  accepts_nested_attributes_for :address

  belongs_to :rink, :foreign_key => :homerink_id
  belongs_to :owner, :class_name => 'Member', :foreign_key => "creator_id"

  has_many :pending_recd_team_requests, :class_name => 'TeamMember',
      :conditions => '(approved = false and rejected = false) and requestor_id != #{creator_id}'
  has_many :pending_sent_team_requests, :class_name => 'TeamMember',
      :conditions => '(approved = false and rejected = false) and requestor_id = #{creator_id}'

  has_many :team_members
  has_many :active_team_members, :class_name => 'TeamMember', :conditions => 'active = true'
  has_many :members, :through => :active_team_members

  has_many :role_members, :as => :roleable, :dependent => :destroy

  attr_accessible :name, :address_attributes

  validates_presence_of :name

  #returns teams with active team members
  #   used to return a user's active team
  scope :active_team, lambda {
    joins(:team_members).
    where("team_members.active = true")
  }
end



# TEAMS ================================
# TODO: Quick Add members
# TODO: Team Request
# TODO: Member Request
# TODO: make commentable