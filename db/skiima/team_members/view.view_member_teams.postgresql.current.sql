DROP VIEW IF EXISTS view_member_teams;
CREATE VIEW view_member_teams AS

SELECT m.id as member_id, t.*
FROM members m

INNER JOIN team_requests active_tm
  ON ((m.id = active_tm.member_requesting_id and active_tm.incoming = true)
  OR (m.id = active_tm.member_requested_id and active_tm.incoming = false))

INNER JOIN teams t
  ON active_tm.team_id = t.id

WHERE active_tm.approved = true