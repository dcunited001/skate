CREATE RULE rule_view_friends_insert AS
ON INSERT TO view_friends DO INSTEAD

-- WHY YOU NO WORKING ??
INSERT INTO friendships
(member_requesting_id, member_requested_id, approved, rejected, active, created_at, updated_at) VALUES
(NEW.member_id, NEW.id, true, false, true, current_timestamp, current_timestamp);

