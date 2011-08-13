class Team < ActiveRecord::Base
  has_one :address, :as => :addressable, :dependent => :destroy
  accepts_nested_attributes_for :address

  belongs_to :rink
  belongs_to :creator, :class_name => 'Member'

  has_many :team_members
  #has_many :team_captains

  validates_presence_of :name

  def creator= member
    Team.transaction do
      creator.remove_role(:teamcreator, self) if creator
      member.assign_role(:teamcreator, self)
      self.creator_id = member.id
    end
  end

  def add_captain member

  end

  def remove_captain member

  end
end


# whats the best way to add and remove roles when added to the creator or captain
# - belongs_to callbacks don't exist


# best way to expose