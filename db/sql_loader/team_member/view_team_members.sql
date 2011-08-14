
-- i'll remove these comments as I determine my strategy here.

-- THIS IS RIDICULOUS !!  $#@& $#& $&#$@& $#@& $##&!!
--    what to do if the team creator changes over the life span of the team??
--    store an original_creator_id field in the team and team_requests to map everything
--    or simply refuse to allow teams to change 'ownership'??  (which is lame)

-- i've decided to use an original_creator_id . . . . nevermind

--  I've been trying to avoid storing the "direction" of the team request
--      this was possible with the friends relationship
--  but it's looking like this is impossible here
--      since you have to key on the team creator_id
--      to implicitly determine the "direction" of the team request
--  and if i want to allow team's to change their creator or owner later
--      that's going to open me up to some particularly nasty bugs
--      which would probably silently ruin the integrity of my data

--  changing team_requests table to use an "incoming" field to determine the team_member

--  =============================================================================

--goal of this view:
--  to take each team
--  and list it's members' individual team_request records (the easy part)
--  then take each team_request record and determine
--  which field to consider the team_member (the hard part)
--  member_requesting_id or member_requested_id?

--  this was moderately difficult to do with members and friends
--  but appears to be very much more complex with teams and team_members
--  although i got it to work in the original application
--  using string substitution in the commented query below

--  =============================================================================
CREATE VIEW view_team_members AS

SELECT t.id as team_id, tm.id as team_request_id, team_mems.*
FROM teams t

INNER JOIN team_requests tm
  ON t.id = tm.team_id
  AND tm.active = true

INNER JOIN view_members_clean team_mems
  --if it's an incoming request, the member requesting is the team member
  --otherwise the member requested is the team member
  ON (team_mems.id = tm.member_requesting_id AND tm.incoming = true)
  OR (team_mems.id = tm.member_requested_id AND tm.incoming = false)

-- FINALLY!  GOT IT!



-- SELECT t.id as team_id, tm.id as team_request_id, this_member.id as member_id, team_mems.*
-- FROM members this_member
--
-- --join to get the member's team
-- INNER JOIN team_requests active_tm
--   ON (this_member.id = active_tm.member_requesting_id
--   OR this_member.id = active_tm.member_requested_id)
--   AND active_tm.active = true
-- INNER JOIN teams t
--   ON active_tm.team_id = t.id
--
-- --join back to team_requests
-- --    to get the current team members
-- INNER JOIN team_requests tm
--   ON t.id = tm.team_id
--   AND tm.active = true
-- INNER JOIN members team_mems
--   ON (team_mems.id = tm.member_requesting_id and t.creator_id = this_member.id)
--   OR (team_mems.id = tm.member_requested_id and t.creator_id != this_member.id)
-- WHERE team_mems.id != this_member.id



-- SELECT team_mems.*
-- FROM devise this_member
-- INNER JOIN team_members active_tm
--   ON  (this_member.id = active_tm.member_id
--   OR this_member.id = active_tm.requestor_id)
--   AND active_tm.active = true
-- INNER JOIN teams t
--   ON active_tm.team_id = t.id
-- INNER JOIN team_members tm
--   ON t.id = tm.team_id
--   AND tm.active = true
-- INNER JOIN devise team_mems
--   ON (team_mems.id = tm.requestor_id and t.creator_id = #{id})
--   OR (team_mems.id = tm.member_id and t.creator_id != #{id})
-- WHERE this_member.id = #{id}
--   AND team_mems.id != #{id}
