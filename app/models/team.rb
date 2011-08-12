class Team < ActiveRecord::Base
  has_one :address, :as => :addressable, :dependent => :destroy
  accepts_nested_attributes_for :address

  belongs_to :homerink, :class_name => 'Rink'
  belongs_to :creator, :class_name => 'Member'

  has_many :team_members
  #has_many :team_captains

  validates_presence_of :name

  def creator= member
    Team.transaction do
      creator.remove_role
    end
  end

  def set_creator member
    #set the creator
    #add and remove roles appropriately
  end

  def add_captain member

  end

  def remove_captain member

  end
end


# whats the best way to add and remove roles when added to the creator or captain
# - belongs_to callbacks don't exist


# best way to expose