class TeamRequest < ActiveRecord::Base
  belongs_to :member_requested, :class_name => 'Member'
  belongs_to :member_requesting, :class_name => 'Member'

  belongs_to :team

  #scope :recd
  #scope :sent

  after_create :set_original_creator

  private

  def set_original_creator
    original_creator_id = team.original_creator_id
  end
end
