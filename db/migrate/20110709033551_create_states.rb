class CreateStates < ActiveRecord::Migration
  def self.up
    create_table :states do |t|
      t.string "name"
      t.string "abbrev"
      t.integer "state_rep_id" ,:default => 0

      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
  
  def self.down
    drop_table :states
  end
end
