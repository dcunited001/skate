DROP RULE IF EXISTS rule_view_friends_d on view_friends;
CREATE RULE rule_view_friends_d AS
ON DELETE TO view_friends DO INSTEAD

UPDATE friendships SET active = false
WHERE id = OLD.friendship_id;
