class Team < ActiveRecord::Base
  has_one :address, :as => :addressable, :dependent => :destroy
  accepts_nested_attributes_for :address

  belongs_to :homerink, :class_name => 'Rink'
  belongs_to :creator, :class_name => 'Member'
  has_many :team_requests
  #has_many :team_members # don't know that this is the best way

  validates_presence_of :name

  def set_creator member
    #set the creator
    #add and remove roles appropriately
  end

  def add_add_captain member

  end
end