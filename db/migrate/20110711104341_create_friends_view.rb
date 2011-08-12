class CreateFriendsView < ActiveRecord::Migration
  def self.up
    SqlLoader::Friend.create
  end

  def self.down
    SqlLoader::Friend.drop
  end
end

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

# INSERT EXAMPLE FROM LOG:
#    [1mINSERT INTO "roles" ("created_at", "member_id", "name", "role_id", "rollable_id", "rollable_type", "updated_at") VALUES
#    ($1, $2, $3, $4, $5, $6, $7) RETURNING "id"ESC[0m  [["created_at", Thu, 11 Aug 2011 22:40:25 UTC +00:00], ["member_id", 101], ["name", "appuser"], ["role_id", nil], ["rollable_id", nil], ["rollable_type", nil], ["updated_at", Thu, 11 Aug 2011 22:40:25 UTC +00:00]]