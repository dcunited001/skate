class CreateRegions < ActiveRecord::Migration
  def self.up
    create_table :regions do |t|
      t.string "name"
      t.string "description"
      t.integer "regional_rep_id", :default => 0

      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end

  def self.down
    drop_table :regions
  end
end
