class Friendship < ActiveRecord::Base
  belongs_to :member_requesting, :class_name => 'Member'
  belongs_to :member_requested, :class_name => 'Member'

  scope :pending, where('active = ? and accepted = ? and rejected = ?', false, false, false)
  scope :active, where('active = ?', true)
  scope :accepted, where('accepted = ?', true)
  scope :rejected, where('rejected = ?', true)
  scope :ended, where('accepted = ? and rejected = ?', false, true)

  scope :sent_from, lambda { |member| where(:member_requesting_id => member.id) }
  scope :sent_to,  lambda { |member| where(:member_requested_id => member.id) }

  def approve
    active = 1
    approved = 1
    save
  end

  def reject
    rejected = 1
    save
  end

  def end_friendship
    active = 0
    rejected = 1
    save
  end
end