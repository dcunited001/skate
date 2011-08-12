CREATE RULE rule_view_friends_delete AS
ON DELETE TO view_friends DO INSTEAD

UPDATE friendships SET active = false
WHERE id = OLD.friendship_id;