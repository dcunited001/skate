class CreateRinks < ActiveRecord::Migration
  def self.up
    create_table :rinks do |t|
      t.string :name
      t.string  :phone
      t.string  :website
      t.string   :owner_name
      t.integer :owner_id
      t.string   :contact_name
      t.integer :contact_id
      t.datetime :register_date
      t.boolean :visible
      t.boolean :verified
      t.datetime :original_verified_date
      t.datetime :last_verified_date
      t.boolean :sanctioned
      t.datetime :original_sanction_date
      t.datetime :last_sanction_date

      t.timestamps
    end
  end

  def self.down
    drop_table :rinks
  end
end
