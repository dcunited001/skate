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

ActiveRecord::Schema.define(:version => 20110201051546) do
  create_table "addresses", :force => true do |t|
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.integer  "region_id"
    t.integer  "state_id", :default => -1
    t.string   "line_one"
    t.string   "line_two"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.decimal  "latitude",   :precision => 10, :scale => 0, :default => -100.00
    t.decimal  "longitude",  :precision => 10, :scale => 0, :default => -200.00
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index :addresses, [:addressable_type, :addressable_id], :unique => true

  create_table "authentications", :force => true do |t|
    t.integer  "member_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string "name"
    t.string "description"
  end

  create_table "role_members", :force => true do |t|
    t.integer "role_id"
    t.integer "member_id"
    t.integer "roleable_id"
    t.string  "roleable_type"
  end

  create_table "members", :force => true do |t|
    t.string   "first_name",                                              :null => false
    t.string   "last_name",                                               :null => false
    t.string   "email",                                   :default => "", :null => false
    t.integer  "homerink_id",    :default => -1
    t.datetime "birthday"
    t.string   "phone"
    t.boolean  "verified"
    t.datetime "original_verified_date"
    t.datetime "last_verified_date"
    t.boolean  "current_member"
    t.datetime "original_membership_date"
    t.datetime "last_membership_date"
    t.integer  "renewal_months"
    t.string   "encrypted_password",       :limit => 128, :default => "", :null => false
    t.string   "password_salt",                           :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                           :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "pro_skater", :default => false
    t.boolean "suspended", :default => false
    t.datetime "suspended_until"

  end
#
  add_index "members", ["email"], :name => "index_members_on_email", :unique => true
  add_index "members", ["reset_password_token"], :name => "index_members_on_reset_password_token", :unique => true

  create_table "rinks", :force => true do |t|
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
#
  create_table "team_members", :force => true do |t|
    t.integer  "team_id"
    t.integer  "member_id"
    t.integer "requestor_id"
    t.boolean "team_request", :default => true
    t.boolean "approved", :default => false
    t.boolean "rejected", :default => false
    t.boolean "active", :default => false
    t.datetime "join_date"
    t.datetime "quit_date"
    t.datetime "kickoff_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
#
  create_table "friendships", :force => true do |t|
    t.integer  "member_id"
    t.integer  "friend_id"
    t.boolean "approved", :default => false
    t.boolean "rejected", :default => false
    t.boolean "active", :default => false
    t.datetime "join_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.integer  "creator_id"
    t.integer  "address_id"
    t.integer  "homerink_id", :default => -1
    t.datetime "sanction_date"
    t.datetime "create_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "allow_comments", :default => true
  end

  create_table "events", :force => true do |t|
    t.string "name"
    t.text "description"

    #foreign keys
    t.integer "address_id"
    t.integer "event_level_id"    #determines the level of the event (national, regional, state)
    t.integer "event_type_id"     #determines the general type of the event (routine, battle, bash, shuffle)
    t.integer "event_format_id"   #determines the specific format of the event, if applicable (divide n conquer rules, etc)
    t.integer "creator_id"
    t.integer "contact_id"
    t.integer "region_id"
    t.integer "state_id"
    t.integer "rink_id"

    t.datetime "startdate"
    t.datetime "enddate"
    t.boolean "visible"
    t.boolean "approved"
    t.boolean "allow_comments", :default => true

    t.datetime "registration_begin"
    t.datetime "registration_end"

    t.datetime "created_at"
    t.datetime "updated_at"
  end

  #the level of the event
  # national
  # regional
  # state
  # other
  create_table "event_levels", :force => true do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  #the type of event
  # routine
  # battle
  # bash
  # shuffle
  # other
  create_table "event_types", :force => true do |t|
    t.string "name"
    t.text "description"

    t.datetime "created_at"
    t.datetime "updated_at"
  end

  #a description of the event format
  create_table "event_formats", :force => true do |t|
    t.string "name"
    t.text "description"
    t.integer "event_type_id"

    t.datetime "created_at"
    t.datetime "updated_at"
  end

  #========================================
  #  Misc Tables
  #========================================
  #allows admins and wsa managers to make announcements
  create_table "announcements", :force => true do |t|
    t.text "message"
    t.integer "posted_by", :default => '-1'
    t.boolean "active"
    t.datetime "remain_posted_until"

    t.datetime "created_at"
    t.datetime "updated_at"
  end

  #allows users to suggest didyouknows and admins to approve them
  create_table "didyouknows", :force => true do |t|
    t.string "message"
    t.integer "submitted_by"
    t.integer "approved_by", :default => '-1'
    t.integer "rate"
    t.boolean "approved" #necessary?
    t.boolean "active"

    t.datetime "created_at"
    t.datetime "updated_at"
  end

  #keeps track of states for regions
  create_table "states", :force => true do |t|
    t.string "name"
    t.string "abbrev"
    t.integer "state_rep_id"  #TODO: ,:default => -1

    t.datetime "created_at"
    t.datetime "updated_at"
  end

  #keeps track of regions
  create_table "regions", :force => true do |t|
    t.string "name"
    t.string "description"
    t.integer "regional_rep_id"

    t.datetime "created_at"
    t.datetime "updated_at"
  end

  #maps regions to states
  create_table "region_states", :force => true do |t|
    t.integer "state_id"
    t.integer "region_id"

    t.datetime "created_at"
    t.datetime "updated_at"
  end

  #========================================
  #  Tables For Event Registration
  #========================================
  #existing divisions for events
#  create_table "divisions", :force => true do |t|
#    t.string "name"
#    t.text "description"
#    t.integer "age_min"
#    t.integer "age_max"
#    t.string "sex"    #male, female, co-ed
#    t.boolean "pro"   #if pro, age does not apply
#    t.datetime "created_at"
#    t.datetime "updated_at"
#  end
#
#  #which skaters are pro
#  create_table "pro_members", :force => true do |t|
#    t.integer "division_id"
#    t.integer "member_id"
#    t.datetime "go_pro_date"
#    t.boolean "active"
#    t.boolean "suspended"
#    t.datetime "created_at"
#    t.datetime "updated_at"
#  end
#
#  #which divisions are offered at each event
#  create_table "event_divisions", :force => true do |t|
#    t.integer "event_id"
#    t.integer "division_id"
#    t.boolean "active"      #in case we want to enable/disable certain divisions
#    t.datetime "created_at"
#    t.datetime "updated_at"
#  end
#
#  #skater's registrations for a specific event
#  create_table "event_registrations", :force => true do |t|
#    t.integer "member_id"
#    t.integer "event_id"
#    t.integer "team_id", :default => -1   #the team the skater registered under
#    t.integer "actual_team_id", :default => -1  #the team the skater actually skated under
#
#    t.datetime "registraion_date"
#    t.datetime "payment_date"
#
#    t.datetime "created_at"
#    t.datetime "updated_at"
#  end
#
#  #skater's registrations for specific divisions at an event
#  create_table "event_registered_divisions", :force => true do |t|
#    t.integer "event_registration_id"
#    t.integer "division_id"
#
#    t.boolean "skated"
#    t.boolean "disqualified"
#    t.boolean "final_placement"         #to be updated by the tabulation
#
#    t.datetime "created_at"
#    t.datetime "updated_at"
#  end
#
#  #which groups are assigned to each division
#  #these may need to be approved or denied for whatever reason
#  create_table "event_registered_division_groups", :force => true do |t|
#    t.string "name"
#    t.integer "event_registered_division_id"
#
#    t.boolean "final"
#    t.boolean "approved"  #default 1?
#    t.boolean "rejected"
#    t.boolean "active"
#
#    t.datetime "created_at"
#    t.datetime "updated_at"
#  end
#
#  #which skaters are assigned to each group
#  #these will be sent like friend requests and accepted
#  #once all are approved, the group will automatically become final before the event
#  create_table "event_registered_division_group_maps", :force => true do |t|
#    t.string "name"
#    t.integer "event_registered_division_id"
#    t.integer "member_id"
#
#    t.boolean "approved"
#    t.boolean "rejected"
#    t.boolean "active"
#
#    t.datetime "add_date"
#    t.datetime "original_accept_date"
#    t.datetime "accept_date"
#
#    t.datetime "created_at"
#    t.datetime "updated_at"
#  end
#
#  #========================================
#  #  Tables For judging
#  #========================================
#  #keeps track of all available judges
#  create_table "judges", :force => true do |t|
#    t.integer "member_id"
#    t.integer "judging_panel_id"     #the panel of the judge
#    t.datetime "certification_date"
#
#    t.datetime "created_at"
#    t.datetime "updated_at"
#  end
#
#  create_table "judging_panels", :force => true do |t|
#    t.string "name"
#    t.text "description"
#
#    t.datetime "created_at"
#    t.datetime "updated_at"
#  end
#
#  #which judges will be available in total for an event
#  create_table "event_judges", :force => true do |t|
#    t.integer "event_id"
#    t.integer "judge_id"
#    t.datetime "date_added"
#    t.datetime "date_removed"
#    t.boolean "active"      #in case we want to enable/disable certain judges
#
#    t.datetime "created_at"
#    t.datetime "updated_at"
#  end
#
#  #which judges are/were assigned to each division
#  create_table "event_division_judges", :force => true do |t|
#    t.integer "event_division_id"
#    t.integer "division_id"
#    t.boolean "active"      #in case certain judges get changed at the last minute
#
#    t.datetime "created_at"
#    t.datetime "updated_at"
#  end
#
#  #maintains the scores for each judge for each division they judge in each event
#  create_table "event_division_judge_scores", :force => true do |t|
#    t.integer "event_division_judges_id"
#    t.integer "scoresheet_id"
#
#    t.datetime "created_at"
#    t.datetime "updated_at"
#  end
#
#  #key for scoresheet stats
#  create_table "scoresheet", :force => true do |t|
#    # FUCK IF I KNOW
#
#    t.datetime "created_at"
#    t.datetime "updated_at"
#  end
end
