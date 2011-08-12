class TeamMate < ActiveRecord::Base
  set_table_name 'view_team_mates'

  def == (team_mate)
    id == team_mate.id
  end
end