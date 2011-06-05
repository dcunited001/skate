class CreateTeams < ActiveRecord::Migration
  def self.up
    create_table :teams do |t|
      t.string :name
      t.integer :creator_id
      t.integer :homerink_id
      t.datetime :sanction_date
      t.datetime :create_date

      t.timestamps
    end
  end

  def self.down
    drop_table :teams
  end
end
