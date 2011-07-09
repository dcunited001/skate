class RinkRole < Role
  def self.names
    { :rink_owner => 'rink_owner',
      :rink_employee => 'rink_employee',
      :rink_patron => 'rink_patron' }
  end

end