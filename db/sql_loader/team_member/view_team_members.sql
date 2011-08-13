CREATE VIEW view_team_members AS

SELECT t.id as team_id, tm.id as team_request_id, team_mems.*
FROM teams t
INNER JOIN team_requests tm
  ON t.id = tm.team_id
  AND tm.active = true
INNER JOIN members team_mems
  ON (team_mems.id = tm.member_requesting_id) -- and t.creator_id = this_member.id)
  OR (team_mems.id = tm.member_requested_id) -- and t.creator_id != this_member.id)