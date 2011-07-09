class OrganizationRole < Role
  def self.names
    { :organization_admin => 'organization_admin',
      :organization_manager => 'organization_manager',
      :organization_regional_rep => 'organization_regional_rep',
      :organization_state_rep => 'organization_state_rep',
      :organization_member => 'organization_member',
      :organization_competitor => 'organization_competitor',
      :organization_top_skater => 'organization_top_skater' }
  end
end