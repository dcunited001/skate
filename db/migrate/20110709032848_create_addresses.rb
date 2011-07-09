class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.integer  "addressable_id"
      t.string   "addressable_type"
      t.integer  "region_id"
      t.integer  "state_id", :default => -1
      t.string   "line_one"
      t.string   "line_two"
      t.string   "city"
      t.string   "state"
      t.string   "zip"
      t.decimal  "latitude",   :precision => 15, :scale => 10, :default => -100.00
      t.decimal  "longitude",  :precision => 15, :scale => 10, :default => -200.00
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index :addresses, [:addressable_type, :addressable_id], :unique => true
  end

  def self.down
    drop_table :addresses
  end
end
