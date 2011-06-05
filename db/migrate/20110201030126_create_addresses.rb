class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.integer :addressable_id
      t.string :addressable_type
      t.integer :region_id
      t.string :line_one
      t.string :line_two
      t.string :city
      t.string :state
      t.string :zip
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end
