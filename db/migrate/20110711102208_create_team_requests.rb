class CreateTeamRequests < ActiveRecord::Migration
  def self.up
    create_table "team_requests", :force => true do |t|
      t.integer  "team_id"
      t.integer  "original_creator_id"
      t.integer  "member_requesting_id"
      t.integer  "member_requested_id"
      t.boolean  "team_request", :default => true
      t.boolean  "approved",     :default => false
      t.boolean  "rejected",     :default => false
      t.boolean  "active",       :default => false
      t.datetime "join_date"
      t.datetime "quit_date"
      t.datetime "kickoff_date"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    #TODO: create view to obtain a list of friends as an association

    add_index :team_requests, [:team_id], :name => "team_id_index"
    add_index :team_requests, [:member_requested_id], :name => "member_requested_id_index"
    #add_index :team_members, [:member_requesting_id], :name => "member_requesting_id_index" #this index is probably going to be read from less
  end

  def self.down
    drop_table :team_requests
  end
end
