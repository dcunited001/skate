class CreateFriendsView < ActiveRecord::Migration
  def self.up

    execute('
CREATE VIEW v_friends AS

SELECT f.member_requested_id, f.member_requesting_id, m.*
FROM members m
JOIN friendships f
ON (m.id = f.member_requested_id) OR (m.id = f.member_requesting_id)
WHERE f.active = true')

# need to get the above view to match the following query without using parameters
# some parameters can be used in the finder_sql

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
    execute('
DROP VIEW v_friends')
  end
end
