-- team members probably should not be able to be deleted from here
CREATE RULE rule_view_team_mates_delete AS
ON DELETE TO view_team_mates DO INSTEAD

UPDATE team_requests SET active = false
WHERE id = OLD.team_request_id;