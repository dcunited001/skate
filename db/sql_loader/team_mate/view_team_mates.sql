CREATE VIEW view_team_mates AS

SELECT t.id as team_id, tm.id as team_request_id, this_member.id as member_id, team_mems.*
FROM view_members_clean this_member

--join to get the member's team
INNER JOIN team_requests active_tm
  ON (this_member.id = active_tm.member_requesting_id
  OR this_member.id = active_tm.member_requested_id)
  AND active_tm.active = true
INNER JOIN teams t
  ON active_tm.team_id = t.id

--join back to team_requests
--    to get the current team members
INNER JOIN team_requests tm
  ON t.id = tm.team_id
  AND tm.active = true
INNER JOIN view_members_clean team_mems
  ON (team_mems.id = tm.member_requesting_id and t.creator_id = this_member.id)
  OR (team_mems.id = tm.member_requested_id and t.creator_id != this_member.id)

--where it's not the original member
WHERE (this_member.id != team_mems.id);