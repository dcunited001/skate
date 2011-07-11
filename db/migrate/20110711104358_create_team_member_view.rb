class CreateTeamMemberViews < ActiveRecord::Migration
  def self.up


#'SELECT team_mems.*
#FROM members this_member
#INNER JOIN team_members active_tm
#  ON  (this_member.id = active_tm.member_id
#  OR this_member.id = active_tm.requestor_id)
#  AND active_tm.active = true
#INNER JOIN teams t
#  ON active_tm.team_id = t.id
#INNER JOIN team_members tm
#  ON t.id = tm.team_id
#  AND tm.active = true
#INNER JOIN members team_mems
#  ON (team_mems.id = tm.requestor_id and t.creator_id = #{id})
#  OR (team_mems.id = tm.member_id and t.creator_id != #{id})
#WHERE this_member.id = #{id}
#  AND team_mems.id != #{id}'

    # also need to change this query to work without parameters
  end

  def self.down

  end
end
