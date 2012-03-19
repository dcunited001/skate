DROP VIEW IF EXISTS view_team_members;
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

--  =============================================================================
-- CREATE RULE rule_view_team_members_delete AS
-- ON DELETE TO view_team_members DO INSTEAD

-- UPDATE team_requests SET active = false
-- WHERE id = OLD.team_request_id;
--  =============================================================================

-- i'll remove these comments as I determine my strategy here.
--    what to do if the team creator changes over the life span of the team??
--    store an original_creator_id field in the team and team_requests to map everything
--    or simply refuse to allow teams to change 'ownership'??  (which is lame)

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