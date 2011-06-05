

# ROLES ================================
# TODO: Allow rinks to create custom role types
# TODO: Allow teams to create custom role types
# TODO: Allow membersto create custom role types for events?
# TODO: Implement business logic for shared, type-specific and custom role types
# TODO: Implement role checking on pages and actions
# TODO: protect certain roles from being deleted/modified??



class Role < ActiveRecord::Base
  has_many :role_members 
  has_many :members, :through => :role_members

  def self.names
    return {
        :admin => 'admin',
        :regional_rep => 'regional_rep',
        :state_rep => 'state_rep',
        :member => 'member',
        :rink_owner => 'rink_owner',
        :team_owner => 'team_owner',
        :wsa_member => 'wsa_member',
        :wsa_manage => 'wsa_manage',
        :team_member => 'team_member'
    }
  end

  # create roles as they're requested if they don't exist already.
  def self.get(role)
    Role.find_by_name(names[role]) or Role.create(:name => names[role], :description => names[role].titleize)
  end

  # ================================
  #NAMED SCOPES
  # ================================
  scope :basic, where(
      "name = 'admin'
      or name = 'wsa_manage'
      or name = 'regional_rep'
      or name = 'state_rep'")

#  scope :basic, lambda {
#    joins(:role_members).
#    where("role_members.roleable_type = 'Admin'")
#  }

end


#INSERT INTO `testapp_dev`.`roles` (`name`, `description`) VALUES ('admin', 'Administrator');
#INSERT INTO `testapp_dev`.`roles` (`name`, `description`) VALUES ('regional_rep', 'WSA Regional Rep');
#INSERT INTO `testapp_dev`.`roles` (`name`, `description`) VALUES ('state_rep', 'WSA State Rep');
#INSERT INTO `testapp_dev`.`roles` (`name`, `description`) VALUES ('member', 'Member of site');
#INSERT INTO `testapp_dev`.`roles` (`name`, `description`) VALUES ('rink_owner', 'Rink Owner');
#INSERT INTO `testapp_dev`.`roles` (`name`, `description`) VALUES ('team_owner', 'Team Owner');
#INSERT INTO `testapp_dev`.`roles` (`name`, `description`) VALUES ('wsa_member', 'WSA Member');
#INSERT INTO `testapp_dev`.`roles` (`name`, `description`) VALUES ('wsa_manager', 'WSA Manager');

#INSERT INTO `testapp_dev`.`role_members` (`role_id`, `member_id`) VALUES (1, 1);