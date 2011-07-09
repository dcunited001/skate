class CreateRoleMembers < ActiveRecord::Migration
  def self.up
    create_table :role_members do |t|
      t.integer "role_id"
      t.integer "member_id"

      t.timestamps
    end

    add_index :role_members, [:role_id], :name => "role_id"
    add_index :role_members, [:member_id], :name => "member_id"
  end

  def self.down
    drop_table :role_members
  end
end
