
#since i didn't use migrations when i originally started this project,
# I've added one migration to take care of all the basic models up to this point
class OneMigrationToStartThemAll < ActiveRecord::Migration
  def self.up

    add_column :members, :first_name, :string
    add_column :members, :last_name, :string
    add_column :members, :homerink_id, :integer, :default => -1
    add_column :members, :birthday, :datetime
    add_column :members, :phone, :string
    add_column :members, :verified, :boolean
    add_column :members, :original_verified_date, :datetime
    add_column :members, :last_verified_date, :datetime
    add_column :members, :current_member, :boolean
    add_column :members, :original_membership_date, :datetime
    add_column :members, :last_membership_date, :datetime
    add_column :members, :renewal_months, :integer
    add_column :members, :pro_skater, :boolean, :default => false
    add_column :members, :suspended, :boolean, :default => false
    add_column :members, :suspended_until, :datetime

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

    create_table :authentications do |t|
      t.integer  "member_id"
      t.string   "provider"
      t.string   "uid"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table :roles do |t|
      t.string "name"
      t.string "description"
    end

    create_table :role_members do |t|
      t.integer "role_id"
      t.integer "member_id"
      t.integer "roleable_id"
      t.string  "roleable_type"
    end

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
  #
    create_table :team_members do |t|
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
    create_table :friendships do |t|
      t.integer  "member_id"
      t.integer  "friend_id"
      t.boolean "approved", :default => false
      t.boolean "rejected", :default => false
      t.boolean "active", :default => false
      t.datetime "join_date"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table :teams do |t|
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

    create_table :events do |t|
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
    create_table :event_levels do |t|
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
    create_table :event_types do |t|
      t.string "name"
      t.text "description"

      t.datetime "created_at"
      t.datetime "updated_at"
    end

    #a description of the event format
    create_table :event_formats do |t|
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
    create_table :announcements do |t|
      t.text "message"
      t.integer "posted_by"
      t.boolean "active"
      t.datetime "remain_posted_until"

      t.datetime "created_at"
      t.datetime "updated_at"
    end

    #allows users to suggest didyouknows and admins to approve them
    create_table :didyouknows do |t|
      t.string "message"
      t.integer "submitted_by"
      t.integer "approved_by", :default => '-1'
      t.integer "rate"
      t.boolean "approved", :default => false
      t.boolean "active"

      t.datetime "created_at"
      t.datetime "updated_at"
    end

    #keeps track of states for regions
    create_table :states do |t|
      t.string "name"
      t.string "abbrev"
      t.integer "state_rep_id" ,:default => 0

      t.datetime "created_at"
      t.datetime "updated_at"
    end

    #keeps track of regions
    create_table :regions do |t|
      t.string "name"
      t.string "description"
      t.integer "regional_rep_id", :default => 0

      t.datetime "created_at"
      t.datetime "updated_at"
    end

    #maps regions to states
    create_table :region_states do |t|
      t.integer "state_id"
      t.integer "region_id"

      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end

  def self.down

    remove_column :members, :first_name
    remove_column :members, :last_name
    remove_column :members, :homerink_id
    remove_column :members, :birthday
    remove_column :members, :phone
    remove_column :members, :verified
    remove_column :members, :original_verified_date
    remove_column :members, :last_verified_date
    remove_column :members, :current_member
    remove_column :members, :original_membership_date
    remove_column :members, :last_membership_date
    remove_column :members, :renewal_months
    remove_column :members, :pro_skater
    remove_column :members, :suspended
    remove_column :members, :suspended_until

    drop_table :addresses
    drop_table :authentications
    drop_table :roles
    drop_table :role_members
    drop_table :members
    drop_table :rinks
    drop_table :team_members
    drop_table :friendships
    drop_table :teams
    drop_table :events
    drop_table :event_levels
    drop_table :event_types
    drop_table :event_formats
    drop_table :announcements
    drop_table :didyouknows
    drop_table :states
    drop_table :regions
    drop_table :region_states
  end
end