class RoleMember < ActiveRecord::Base
  belongs_to :member
  belongs_to :role

  belongs_to :roleable, :polymorphic => true


  #shortcut methods to create role_members of specific type
  def RoleMember.new_of_type(type)
    rm = RoleMember.new
    rm.roleable_type = type
    rm
  end

  #shortcut methods to create admin role_members
  def RoleMember.new_of_admin
    rm = RoleMember.new
    rm.roleable_type = 'Admin'
    rm.roleable_id = -1
    rm
  end

  #reverse methods for polymorphism
  def team
    if roleable_type == 'Team'
      Team.find(roleable_id)
    end
  end

  def rink
    if roleable_type == 'Rink'
      Rink.find(roleable_id)
    end
  end
end