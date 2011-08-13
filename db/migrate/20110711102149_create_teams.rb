class CreateTeams < ActiveRecord::Migration
  def self.up
    create_table "teams", :force => true do |t|
      t.string   "name"
      t.integer  "original_creator_id"
      t.integer  "creator_id"
      t.integer  "address_id"
      t.integer  "rink_id",    :default => -1
      t.datetime "sanction_date"
      t.datetime "create_date"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.boolean  "allow_comments", :default => true
    end

    add_index :teams, [:rink_id], :name => "rink_id_index"
  end

  def self.down
    drop_table :teams
  end
end
