class Team < ActiveRecord::Base
  has_one :address, :as => :addressable, :dependent => :destroy
  accepts_nested_attributes_for :address

  belongs_to :rink
  belongs_to :creator, :class_name => 'Member'

  validates_presence_of :name

  def set_creator
    #set the creator
    #add and remove roles appropriately
  end
end