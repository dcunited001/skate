class CreateRinks < ActiveRecord::Migration
  def self.up
    create_table :rinks do |t|
      t.string   "name"
      t.string   "phone"
      t.string   "website"
      t.string   "email"
      t.string   "owner_name"
      t.integer  "owner_id",  :default => -1
      t.boolean "contacted",  :default => false
      t.datetime "original_contact_date"
      t.datetime "last_contact_date"
      t.string   "contact_name"
      t.integer  "contact_id",  :default => -1
      t.datetime "register_date"
      t.boolean  "visible",  :default => false
      t.boolean  "verified",  :default => false
      t.datetime "original_verified_date"
      t.datetime "last_verified_date"
      t.boolean  "sanctioned",  :default => false
      t.datetime "original_sanction_date"
      t.datetime "last_sanction_date"
      t.text "description"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.boolean "allow_comments", :default => false
    end

    add_index :rinks, [:owner_id], :name => "owner_id_index"
    add_index :rinks, [:contacted], :name => "contacted_index"
    add_index :rinks, [:visible], :name => "visible_index"
    #add_index :rinks, [:verified], :name => "verified_index"
  end

  def self.down
    drop_table :rinks
  end
end
