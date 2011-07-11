class CreateFriendships < ActiveRecord::Migration
  def self.up
    create_table "friendships", :force => true do |t|
      t.integer  "member_requesting"
      t.integer  "member_requested"
      t.boolean  "approved",   :default => false
      t.boolean  "rejected",   :default => false
      t.boolean  "active",     :default => false
      t.datetime "join_date"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    #TODO: create view to obtain a list of friends as an association
    add_index :friendships, [:member_requested, :approved], :name => "member_requested_approved_index"
    #add_index :friendships, [:member_requesting, :approved], :name => "member_requesting_approved_index"
    add_index :friendships, [:member_requested, :member_requesting, :active], :name => "member_requested_member_requesting_active_index"
  end

  def self.down
    #drop view
    drop_table :friendships
  end
end
