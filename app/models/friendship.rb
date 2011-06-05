
class Friendship < ActiveRecord::Base
  belongs_to :member
  belongs_to :friend, :class_name => "Member", :foreign_key => "friend_id"

  scope :sent_from, lambda {|member| where(:member_id => member.id)}
  scope :sent_to,  lambda {|member| where(:friend_id => member.id)}

  scope :of_member, lambda {|member| where('member_id = ? or friend_id = ?', member.id, member.id)}

  scope :active, where('active = 1')

  validate :not_already_friends, :not_already_requested, :not_self
  
  def not_already_friends
    errors.add(:already_friends, 'Already Friends') if
        (member.already_friends_with friend)
  end

  def not_already_requested
    errors.add(:already_requested, 'Already Requested') if
        (member.already_friend_request_from friend or
        member.already_friend_request_to friend)
  end

  def not_self
    errors.add(:not_self, "Can't F-Request Yourself") if
        member == friend
  end
end