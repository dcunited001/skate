class AppRole < Role
  def self.names
    { :app_admin => 'app_admin',
      :app_moderator => 'app_moderator',
      :app_parent => 'app_parent',
      :app_skater => 'app_skater',
      :app_member => 'app_member' }
  end
end