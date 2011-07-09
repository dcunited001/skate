class TeamRole < Role
  def self.names
    { :team_captain => 'team_captian',
      :team_owner => 'team_owner',
      :team_member => 'team_member' }
  end
end