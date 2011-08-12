CREATE RULE rule_view_team_members_delete AS
ON DELETE TO view_team_members DO INSTEAD

UPDATE team_requests SET active = false
WHERE id = OLD.team_request_id;