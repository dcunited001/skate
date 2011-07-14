class Friendship < ActiveRecord::Base
  belongs_to :member_requesting, :class_name => 'Member'
  belongs_to :member_requested, :class_name => 'Member'

  scope :pending, where('active = ? and accepted = ? and rejected = ?', false, false, false)
  scope :active, where('active = ?', true, true)
  scope :accepted, where('accepted = ?', true)
  scope :rejected, where('rejected = ?', true)
  scope :ended, where('accepted = ? and rejected = ?', false)
end