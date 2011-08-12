class CreateTeamMemberView < ActiveRecord::Migration
  def self.up

    execute('
CREATE VIEW v_team_members AS

SELECT t.id as team_id, tm.id as team_request_id, this_member.id as member_id, team_mems.*
FROM members this_member
INNER JOIN team_requests active_tm
  ON (this_member.id = active_tm.member_requesting_id
  OR this_member.id = active_tm.member_requested_id)
  AND active_tm.active = true
INNER JOIN teams t
  ON active_tm.team_id = t.id
INNER JOIN team_requests tm
  ON t.id = tm.team_id
  AND tm.active = true
INNER JOIN members team_mems
  ON (team_mems.id = tm.member_requesting_id and t.creator_id = this_member.id)
  OR (team_mems.id = tm.member_requested_id and t.creator_id != this_member.id)
WHERE (this_member.id != team_mems.id);')

    execute('
CREATE RULE v_team_members_delete AS
ON DELETE TO v_team_members DO INSTEAD

UPDATE team_requests SET active = false
WHERE id = OLD.team_request_id;')

#'SELECT team_mems.*
#FROM devise this_member
#INNER JOIN team_members active_tm
#  ON  (this_member.id = active_tm.member_id
#  OR this_member.id = active_tm.requestor_id)
#  AND active_tm.active = true
#INNER JOIN teams t
#  ON active_tm.team_id = t.id
#INNER JOIN team_members tm
#  ON t.id = tm.team_id
#  AND tm.active = true
#INNER JOIN devise team_mems
#  ON (team_mems.id = tm.requestor_id and t.creator_id = #{id})
#  OR (team_mems.id = tm.member_id and t.creator_id != #{id})
#WHERE this_member.id = #{id}
#  AND team_mems.id != #{id}'

    # also need to change this query to work without parameters
  end

  def self.down
    drop_table :team_member_views
  end
end
