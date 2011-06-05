class CreateTeamMembers < ActiveRecord::Migration
  def self.up
    create_table :team_members do |t|
      t.integer :team_id
      t.integer :member_id
      t.datetime :join_date
      t.boolean :active
      t.datetime :join_date
      t.datetime :quit_date

      t.timestamps
    end
  end

  def self.down
    drop_table :team_members
  end
end
