class CreateFriendships < ActiveRecord::Migration
  def self.up
    create_table "friendships", :force => true do |t|
      t.integer  "member_requesting_id"
      t.integer  "member_requested_id"
      t.boolean  "approved",   :default => false
      t.boolean  "rejected",   :default => false
      t.boolean  "active",     :default => false
      t.datetime "join_date"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index :friendships, [:member_requested_id, :approved], :name => "member_requested_approved_index"
    #add_index :friendships, [:member_requesting_id, :approved], :name => "member_requesting_approved_index"
    add_index :friendships, [:member_requested_id, :member_requesting_id, :active], :name => "member_requested_member_requesting_active_index"
  end

  def self.down
    drop_table :friendships
  end
end
