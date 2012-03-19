DROP VIEW IF EXISTS view_team_mates;
CREATE VIEW view_team_mates AS

SELECT m.id as member_id, vtm.*
FROM members m

INNER JOIN team_requests active_tm
  ON ((m.id = active_tm.member_requesting_id and active_tm.incoming = true)
  OR (m.id = active_tm.member_requested_id and active_tm.incoming = false))
  AND active_tm.active = true

INNER JOIN teams t
  ON active_tm.team_id = t.id

INNER JOIN view_team_members vtm
  ON t.id = vtm.team_id

WHERE m.id != vtm.id

--  =============================================================================
-- team members probably should not be able to be deleted from here
-- CREATE RULE rule_view_team_mates_delete AS
-- ON DELETE TO view_team_mates DO INSTEAD

-- UPDATE team_requests SET active = false
-- WHERE id = OLD.team_request_id;
--  =============================================================================