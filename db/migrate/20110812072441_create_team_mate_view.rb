class CreateTeamMateView < ActiveRecord::Migration
  def self.up
    SqlLoader::TeamMate.create
  end

  def self.down
    SqlLoader::TeamMate.drop
  end
end
