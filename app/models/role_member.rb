class RoleMember < ActiveRecord::Base
  belongs_to :member
  belongs_to :role

  #implement rollable
end