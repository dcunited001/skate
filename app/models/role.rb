
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
end
