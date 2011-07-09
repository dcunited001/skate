class CreateRegionStates < ActiveRecord::Migration
  def self.up
    create_table :region_states do |t|
      t.integer "state_id"
      t.integer "region_id"

      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end

  def self.down
    drop_table :region_states
  end
end
