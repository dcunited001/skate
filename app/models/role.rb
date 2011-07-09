
class Role < ActiveRecord::Base
  ADMIN = 'app_admin'
  MEMBER = 'app_member'

  has_many :role_members
  has_many :members, :through => :role_members

  def self.names
    all_names = {}
    all_types = self.types.values.map { |role_type| eval("#{role_type}Role").names }
    all_types.each do |type|
      type.each_pair {|k,v| all_names[k] = v }
    end
    all_names
  end

  def self.types
    { :app => 'App',
      :organization => 'Organization',
      :event => 'Event',
      :rink => 'Rink',
      :team => 'Team' }
  end

  # create roles as they're requested if they don't exist already.
  def self.get(role)
    self.find_by_name(names[role]) or self.create(:name => names[role], :description => names[role].titleize)
  end

  def get_role_type_from(name)
    name.split('_')[0].capitalize
  end
end
