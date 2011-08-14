class Team < ActiveRecord::Base
  has_one :address, :as => :addressable, :dependent => :destroy
  accepts_nested_attributes_for :address

  belongs_to :rink
  belongs_to :original_creator, :class_name => 'Member'
  belongs_to :creator, :class_name => 'Member'

  has_many :team_requests
  has_many :team_members
  has_many :team_captains, :before_add => :add_captain, :before_remove => :remove_captain

  validates_presence_of :name

  def creator= member
    Team.transaction do
      #detach the old creator and remove roles (this will invoke the delete rule on the view)
      if creator
        TeamMember.where(:team_id => self.id, :member_requesting_id => creator.id, :member_requested_id => creator.id).first.delete
        creator.remove_role(:teamcreator, self)
      else
        self.original_creator_id = member.id
      end

      #create a special TeamRequest record for the new creator and assign roles
      #   hopefully in the future i can get the insert rules to work on the TeamMember view
      team_requests << TeamRequest.create!(
        :member_requesting_id => member.id,
        :member_requested_id => member.id,
        :approved => true,
        :active => true,
        :incoming => false)
      member.assign_role(:teamcreator, self)

      #finally, if all is well in transaction-land,
      #   set the creator_id column on the team
      self.creator_id = member.id
    end
  end

  def add_captain captain

  end

  def remove_captain captain

  end



end


# whats the best way to add and remove roles when added to the creator or captain
# - belongs_to callbacks don't exist


# best way to expose