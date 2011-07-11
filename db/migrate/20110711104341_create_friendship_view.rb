class CreateFriendshipView < ActiveRecord::Migration
  def self.up

#'SELECT m.*
#from friendships f
#INNER JOIN members m
#    on (m.id = f.member_id and f.member_id != #{id})
#    or (m.id = f.friend_id and f.friend_id != #{id})
#where (f.member_id = #{id} or f.friend_id = #{id})
#    and active = true;'

    # going to need to change this view to join from the members first, then friendships (and probably back to members)
  end

  def self.down

  end
end
