class MemberTeam < Team
  set_table_name 'view_member_teams'

  def == (team)
    id == team.id
  end
end