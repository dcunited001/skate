# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110709033626) do

  create_table "addresses", :force => true do |t|
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.integer  "region_id"
    t.integer  "state_id",                                         :default => -1
    t.string   "line_one"
    t.string   "line_two"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.decimal  "latitude",         :precision => 15, :scale => 10, :default => -100.0
    t.decimal  "longitude",        :precision => 15, :scale => 10, :default => -200.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses", ["addressable_type", "addressable_id"], :name => "index_addresses_on_addressable_type_and_addressable_id", :unique => true

  create_table "members", :force => true do |t|
    t.string   "email",                                   :default => "",    :null => false
    t.string   "encrypted_password",       :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                           :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "homerink_id",                             :default => -1
    t.datetime "birthday"
    t.string   "phone"
    t.boolean  "verified"
    t.datetime "original_verified_date"
    t.datetime "last_verified_date"
    t.boolean  "current_member"
    t.datetime "original_membership_date"
    t.datetime "last_membership_date"
    t.integer  "renewal_months"
    t.boolean  "pro_skater",                              :default => false
    t.boolean  "suspended",                               :default => false
    t.datetime "suspended_until"
  end

  add_index "members", ["email"], :name => "index_members_on_email", :unique => true
  add_index "members", ["reset_password_token"], :name => "index_members_on_reset_password_token", :unique => true

  create_table "region_states", :force => true do |t|
    t.integer  "state_id"
    t.integer  "region_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regions", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "regional_rep_id", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rinks", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "website"
    t.string   "email"
    t.string   "owner_name"
    t.integer  "owner_id",               :default => -1
    t.boolean  "contacted",              :default => false
    t.datetime "original_contact_date"
    t.datetime "last_contact_date"
    t.string   "contact_name"
    t.integer  "contact_id",             :default => -1
    t.datetime "register_date"
    t.boolean  "visible",                :default => false
    t.boolean  "verified",               :default => false
    t.datetime "original_verified_date"
    t.datetime "last_verified_date"
    t.boolean  "sanctioned",             :default => false
    t.datetime "original_sanction_date"
    t.datetime "last_sanction_date"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "allow_comments",         :default => false
  end

  add_index "rinks", ["contacted"], :name => "contacted_index"
  add_index "rinks", ["owner_id"], :name => "owner_id_index"
  add_index "rinks", ["visible"], :name => "visible_index"

  create_table "role_members", :force => true do |t|
    t.integer  "role_id"
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "role_members", ["member_id"], :name => "member_id"
  add_index "role_members", ["role_id"], :name => "role_id"

  create_table "roles", :force => true do |t|
    t.string "name"
    t.string "type"
    t.string "description"
  end

  create_table "states", :force => true do |t|
    t.string   "name"
    t.string   "abbrev"
    t.integer  "state_rep_id", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
