class CreateFriendsView < ActiveRecord::Migration
  def self.up

    execute('
CREATE VIEW v_friends AS

SELECT m.id as member_id, f.id as friendship_id, m2.*
FROM members m
  JOIN friendships f
  ON (m.id = f.member_requested_id) OR (m.id = f.member_requesting_id)
JOIN members m2
  ON ((f.member_requested_id = m2.id) OR (f.member_requesting_id = m2.id))
  AND (m.id != m2.id)
WHERE f.active = true')

# DELETE RULE
    execute('
CREATE RULE v_friends_delete AS
ON DELETE TO v_friends DO INSTEAD

UPDATE friendships SET active = 0
WHERE id = OLD.friendship_id;
')



# Insert Rule for Friendships won't work at the moment,
#     because Friends.<< is expecting a Friend and not a member
# besides, i don't want my users to circumvent the workflow

#
# INSERT RULE (This will be used by factories to automatically insert friends)
#    execute('
#CREATE RULE v_friends_insert AS
#ON INSERT TO v_friends DO INSTEAD
#
#INSERT INTO friendships
#( columns )  . . .
#
#')


    # This takes care of Member.first.friends.first.delete
    # without the developer having to know anything about the sql implementation

# CREATE RULE v_friends_delete AS ON DELETE TO v_friends
# DO INSTEAD UPDATE friendships SET active = 0 WHERE id = OLD.friendship_id

# (need to add friendships.id to the view as well)


  end

  def self.down
    execute('
DROP VIEW v_friends')
  end
end
