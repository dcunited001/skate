class CreateTeamMemberView < ActiveRecord::Migration
  def self.up
    SqlLoader::TeamMember.create
  end

  def self.down
    SqlLoader::TeamMember.drop
  end
end

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
