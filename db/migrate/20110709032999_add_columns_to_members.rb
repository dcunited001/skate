class AddColumnsToMembers < ActiveRecord::Migration
  def self.up
    add_column :members, :alias, :string
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
  end

  def self.down
    remove_column :members, :alias
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
  end
end
