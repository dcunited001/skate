class RoleMember < ActiveRecord::Base
  belongs_to :member
  belongs_to :role

  belongs_to :roleable, :polymorphic => true



end