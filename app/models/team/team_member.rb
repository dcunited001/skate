class TeamMember < Member
  set_table_name 'view_team_members'

  def == (team_member)
    id == team_member.id
  end
end
