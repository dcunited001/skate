class AddTeamMembersObjects < ActiveRecord::Migration
  def up
    ski = Skiima.new(Rails.env.to_sym)
    ski.up(:team_members)
  end

  def down
    ski = Skiima.new(Rails.env.to_sym)
    ski.down(:team_members)
  end
end
