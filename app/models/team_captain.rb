class TeamCaptain < TeamMember
  set_table_name 'view_team_captains'

  def == (team_member)
    id == team_member.id
  end
end