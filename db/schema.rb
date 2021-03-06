# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20120319104323) do

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

  create_table "friendships", :force => true do |t|
    t.integer  "member_requesting_id"
    t.integer  "member_requested_id"
    t.boolean  "approved",             :default => false
    t.boolean  "rejected",             :default => false
    t.boolean  "active",               :default => false
    t.datetime "join_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friendships", ["member_requested_id", "approved"], :name => "member_requested_approved_index"
  add_index "friendships", ["member_requested_id", "member_requesting_id", "active"], :name => "member_requested_member_requesting_active_index"

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
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
    t.string   "alias"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "rink_id",                                 :default => -1
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

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "member_id"
    t.integer  "role_id"
    t.integer  "rollable_id"
    t.string   "rollable_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "states", :force => true do |t|
    t.string   "name"
    t.string   "abbrev"
    t.integer  "state_rep_id", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_requests", :force => true do |t|
    t.integer  "team_id"
    t.integer  "member_requesting_id"
    t.integer  "member_requested_id"
    t.boolean  "incoming",             :default => true
    t.boolean  "team_request",         :default => true
    t.boolean  "approved",             :default => false
    t.boolean  "rejected",             :default => false
    t.boolean  "active",               :default => false
    t.datetime "join_date"
    t.datetime "quit_date"
    t.datetime "kickoff_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "team_requests", ["member_requested_id"], :name => "member_requested_id_index"
  add_index "team_requests", ["team_id"], :name => "team_id_index"

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.integer  "original_creator_id"
    t.integer  "creator_id"
    t.integer  "address_id"
    t.integer  "rink_id",             :default => -1
    t.datetime "sanction_date"
    t.datetime "create_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "allow_comments",      :default => true
  end

  add_index "teams", ["rink_id"], :name => "rink_id_index"

end
